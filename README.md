# FoundryVTT docker-compose

[한국어 가이드](https://ttgt.shoyuvanilla.net/vtt/foundryvtt/hosting/cloud_server.html)

![](../images/fvtt_cloud00.png)

First, purchase Foundry Virtual Tabletop license from [official website](https://foundryvtt.com) and [download](https://foundryvtt.com/community/shoyu-vanilla/licenses) for Node.js.

## Initial Setup

![](../images/fvtt_cloud06.png)

Connect to your server via ssh terminal and enter the following command;

```
bash <(curl -s https://raw.githubusercontent.com/ShoyuVanilla/FoundryVTT-docker-compose/master/install.sh)
```

![](../images/fvtt_cloud07.png)

If some message like this show up asking for restart services, select \<Yes\> with left arrow key and press enter.

After the installation is finished, enter the following two commands;

```
sudo su ${USER}
foundry up
```

![](../images/fvtt_cloud08.png)

Then you will see the following messages;

```
Creating tinyfilemanager ... done
Creating foundryvtt      ... done
```

## Tiny File Manager Configuration

By `foundry up` command, [Tiny File Manager](https://tinyfilemanager.github.io/) and Foundry Virtual Tabletop are running on Docker.

But as you haven't installed your Foundry Virtual Tabletop downloaded at the very begining of this guide yet, the Foundry Virtual Tabletop runnig on your server is a mere empty container.

We'll install Foundry Virtual Tabletop with Tiny File Manager.

Add port `8080` for TCP connection in your server's firewall rules.
It's because the Tiny File Manager is running on port `8080`.

![](../images/fvtt_cloud11.png)

Open a web browser's new tab and enter `<Server's Public IP>:8080`, e.g. `13.124.21.172:8080`, which leads to the Tiny File Manager's login page.

Initial username and password are:

```
Username: admin
Password: admin@123
```

![](../images/fvtt_cloud12.png)

The file list will show up.
Open the `tinyfilemanager-config.json` file at the bottom of the list.

![](../images/fvtt_cloud13.png)

Click the file's name to see details and click the **Edit** button to edit it.

![](../images/fvtt_cloud14.png)

There are two premade users `"admin"` and `"user"`.
`"admin"` is an administrator user which can access all files and directories under this package's installation path.

`"user"` has limited access which can only browse and edit files and directories under Foundry Virtual Tabletop's Data directory.
This limitation is set by `"userdir"` value.

You can add or remove users by editing this json file.

We'll `"username"`과 `"password"` 항목을 수정할 것입니다.
Change `admin`, `admin@123`, `user`, and `12345` to your desired username and password.

As this Tiny File Manager will continue to be used for uploads and backups after the installation is completed, change the default username and password to prevent hacking.

After you finish editing, press the **Save** button.

## Foundry Virtual Tabletop Installation

![](../images/fvtt_cloud15.png)

From the Tiny File Manager's home directory, move to `foundryvtt` directory.
Click the **Upload** button on top right corner to open the upload page.

![](../images/fvtt_cloud16.png)

Drag and drop your Foundry Virtual Tabletop zip file downloaded from official website.

![](../images/fvtt_cloud17.png)
After the upload is completed, go back to `foundryvtt` directory and UnZip the uploaded file.

Now that Foundry Virtual Tabletop is installed, it's time to restart the existing container, which was mere empty one.

Go back to your ssh terminal and stop the containers with following command;

```
foundry down
```

and restart them with;

```
foundry up
```

![](../images/fvtt_cloud18.png)

If you see the page that asks for the license key as shown above after entering the server's public IP in the address bar of your internet browser, the installation is completed.

Other players can connect to this server with its public IP.
For security reasons, set an **Administrator Password** at the  **Configuration** tab of Foundry Virtual Tabletop's **Setup** page.

## Upload and Back Up Files

![](../images/fvtt_cloud19.png)

Login to Tiny File Manager and go to `foundryvtt` directory.

![](../images/fvtt_cloud22.png)

Upload the multimedia files you want to use in Foundry Virtual Tabletop files to sub-paths of `Data` directory.

![](../images/fvtt_cloud23.png)

And Zip the entire `Data` folder and download it for back up.

## Use SSL Encryption (Optional)

Create subdomains for Foundry Virtual Tabletop and Tiny File Manager and link both of them to server's public IP, without port number.

![](../images/fvtt_cloud24.png)

Login to Tiny File Manager and edit the `docker-compose-https.override.yml` file.

![](../images/fvtt_cloud25.png)

Change the `foo.bar.com` and `foo.baz.com` parts of `DOMAINS` to the subdomain of Foundry Virtual Tabletop and File Manager, respectively, and save the changes.

Add port `443` for HTTPS connection in your server's firewall rules and remove `8080` which is no longer needed.

On your ssh terminal, enter

```
foundry down
```

to stop the containers and enter

```
foundry-https up
```

to start them again in HTTPS settings, and that's it.
To stop https containers, enter `foundry-https down`.

>⚠️ If your server returns 403 after SSL settings, it may be because your DNS information is not yet propagated to DNS servers that Let's Encryption is using.
>Try again after a while with `foundry-https up`.
