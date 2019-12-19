Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4808126FC7
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2019 22:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLSVik (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Dec 2019 16:38:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36190 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSVik (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Dec 2019 16:38:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id w1so8982798otg.3;
        Thu, 19 Dec 2019 13:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfeeNW3xmudQC/YFevQ3lQ5kCZ4yhVzFGlZeZB9E96Y=;
        b=Ah0GDw8W2qjGBTk2I7oVK6i2oNgtuzGUpaAGtxWWLAaPYFkCp3A+oBvIuGIetPIpml
         nlZtd7PpMDDVGs+IIbUVxHytPn7kFzjmmTILBQGBdcTFS+10RIJNGn6HdPc2e1EtnMrh
         F2LnWxXqMeXQ8V2LCfnlY9odzOq6rnM6UsXLvsvfx6HahM2xDYQzPs3QclORcfLAv9Ua
         jAsxOn3UGuPnMS8UnO8lfhWoyLqRkFC5sNIX1Mb7w763PHDDFg80i4UnD7pO/8z/Lr9c
         7N8VxzLhcJCgWbGwJV6gQBUaJSk9hGzVRC1hH16rRrPmtmUeGhnx1slRXTAzCVC7Nw9O
         uwrQ==
X-Gm-Message-State: APjAAAV7C/WOgDvzIT50NSf/oyVv3iav2Nc8OZok5RUg7WvGP+T63emT
        eF/l4HCVIRy+BeQ8MT/A090tvuOM5zL3FBhPyoQ=
X-Google-Smtp-Source: APXvYqx1CsqYneLcCG4qS1okfo+QFG62HuZxc1DLLTS+LfqIoajjt3Gf/tUwLuikiL2JlnbHmr4P9ptMCWG//laxGT8=
X-Received: by 2002:a9d:62c7:: with SMTP id z7mr5758606otk.189.1576791519567;
 Thu, 19 Dec 2019 13:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20191213234840.9791-1-srinivas.pandruvada@linux.intel.com> <20191213234840.9791-3-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20191213234840.9791-3-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Dec 2019 22:38:28 +0100
Message-ID: <CAJZ5v0j7nQxLt55Q-+jqNwmW7RNvjGsQws5bUDSv7X3iojX6Dg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI / fan: Display fan performance state information
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 14, 2019 at 12:48 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When _FPS object indicates support of variable speed fan, thermal cooling
> devices for fan shows max performance state count using attribute
> "max_state" greater than or equal to 1.
>
> But the thermal cooling device doesn't display properties of each
> performance state. This is not enough for smart fan control user space
> software, which also considers speed, power and noise level.
>
> This change presents fan performance states attributes under acpi
> device for the fan. This will be under:
> /sys/bus/acpi/devices/devices/INT3404:00
> or
> /sys/bus/platform/devices/PNP0C0B:00.
>
> For example:
> $ ls /sys/bus/acpi/devices/INT3404\:00
> description  path           state0   state11  state4  state7  status
> hid          physical_node  state1   state2   state5  state8  subsystem
> modalias     power          state10  state3   state6  state9  uevent
> uid          wakeup
>
> Here each state* attribute is representing a performance state.
>
> Contents of state* attribute are formatted using:
> control_percent:trip_point:speed_rpm:noise_level_mdb:power_mw
>
> $ cat /sys/bus/acpi/devices/INT3404\:00/state10
> 95:0:11600:47500:4500
>
> For more information refer to:
> Documentation/acpi/fan_performance_states.txt
>
> While here, return correct error from acpi_fan_probe() when
> acpi_fan_get_fps() or acpi_fan_get_fif() fails.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Folded the (rewritten) [1/2] into this one and queued it up for 5.6, thanks!

> ---
>  drivers/acpi/fan.c | 96 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 88 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index 816b0803f7fb..86d2417953b5 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -44,12 +44,16 @@ static const struct dev_pm_ops acpi_fan_pm = {
>  #define FAN_PM_OPS_PTR NULL
>  #endif
>
> +#define ACPI_FPS_NAME_LEN      20
> +
>  struct acpi_fan_fps {
>         u64 control;
>         u64 trip_point;
>         u64 speed;
>         u64 noise_level;
>         u64 power;
> +       char name[ACPI_FPS_NAME_LEN];
> +       struct device_attribute dev_attr;
>  };
>
>  struct acpi_fan_fif {
> @@ -265,6 +269,39 @@ static int acpi_fan_speed_cmp(const void *a, const void *b)
>         return fps1->speed - fps2->speed;
>  }
>
> +static ssize_t show_state(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct acpi_fan_fps *fps = container_of(attr, struct acpi_fan_fps, dev_attr);
> +       int count;
> +
> +       if (fps->control == 0xFFFFFFFF || fps->control > 100)
> +               count = snprintf(buf, PAGE_SIZE, "not-defined:");
> +       else
> +               count = snprintf(buf, PAGE_SIZE, "%lld:", fps->control);
> +
> +       if (fps->trip_point == 0xFFFFFFFF || fps->trip_point > 9)
> +               count += snprintf(&buf[count], PAGE_SIZE, "not-defined:");
> +       else
> +               count += snprintf(&buf[count], PAGE_SIZE, "%lld:", fps->trip_point);
> +
> +       if (fps->speed == 0xFFFFFFFF)
> +               count += snprintf(&buf[count], PAGE_SIZE, "not-defined:");
> +       else
> +               count += snprintf(&buf[count], PAGE_SIZE, "%lld:", fps->speed);
> +
> +       if (fps->noise_level == 0xFFFFFFFF)
> +               count += snprintf(&buf[count], PAGE_SIZE, "not-defined:");
> +       else
> +               count += snprintf(&buf[count], PAGE_SIZE, "%lld:", fps->noise_level * 100);
> +
> +       if (fps->power == 0xFFFFFFFF)
> +               count += snprintf(&buf[count], PAGE_SIZE, "not-defined\n");
> +       else
> +               count += snprintf(&buf[count], PAGE_SIZE, "%lld\n", fps->power);
> +
> +       return count;
> +}
> +
>  static int acpi_fan_get_fps(struct acpi_device *device)
>  {
>         struct acpi_fan *fan = acpi_driver_data(device);
> @@ -295,12 +332,13 @@ static int acpi_fan_get_fps(struct acpi_device *device)
>         }
>         for (i = 0; i < fan->fps_count; i++) {
>                 struct acpi_buffer format = { sizeof("NNNNN"), "NNNNN" };
> -               struct acpi_buffer fps = { sizeof(fan->fps[i]), &fan->fps[i] };
> +               struct acpi_buffer fps = { offsetof(struct acpi_fan_fps, name),
> +                                               &fan->fps[i] };
>                 status = acpi_extract_package(&obj->package.elements[i + 1],
>                                               &format, &fps);
>                 if (ACPI_FAILURE(status)) {
>                         dev_err(&device->dev, "Invalid _FPS element\n");
> -                       break;
> +                       goto err;
>                 }
>         }
>
> @@ -308,6 +346,24 @@ static int acpi_fan_get_fps(struct acpi_device *device)
>         sort(fan->fps, fan->fps_count, sizeof(*fan->fps),
>              acpi_fan_speed_cmp, NULL);
>
> +       for (i = 0; i < fan->fps_count; ++i) {
> +               struct acpi_fan_fps *fps = &fan->fps[i];
> +
> +               snprintf(fps->name, ACPI_FPS_NAME_LEN, "state%d", i);
> +               fps->dev_attr.show = show_state;
> +               fps->dev_attr.store = NULL;
> +               fps->dev_attr.attr.name = fps->name;
> +               fps->dev_attr.attr.mode = 0444;
> +               status = sysfs_create_file(&device->dev.kobj, &fps->dev_attr.attr);
> +               if (status) {
> +                       int j;
> +
> +                       for (j = 0; j < i; ++j)
> +                               sysfs_remove_file(&device->dev.kobj, &fan->fps[j].dev_attr.attr);
> +                       break;
> +               }
> +       }
> +
>  err:
>         kfree(obj);
>         return status;
> @@ -330,14 +386,20 @@ static int acpi_fan_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, fan);
>
>         if (acpi_fan_is_acpi4(device)) {
> -               if (acpi_fan_get_fif(device) || acpi_fan_get_fps(device))
> -                       goto end;
> +               result = acpi_fan_get_fif(device);
> +               if (result)
> +                       return result;
> +
> +               result = acpi_fan_get_fps(device);
> +               if (result)
> +                       return result;
> +
>                 fan->acpi4 = true;
>         } else {
>                 result = acpi_device_update_power(device, NULL);
>                 if (result) {
>                         dev_err(&device->dev, "Failed to set initial power state\n");
> -                       goto end;
> +                       goto err_end;
>                 }
>         }
>
> @@ -350,7 +412,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
>                                                 &fan_cooling_ops);
>         if (IS_ERR(cdev)) {
>                 result = PTR_ERR(cdev);
> -               goto end;
> +               goto err_end;
>         }
>
>         dev_dbg(&pdev->dev, "registered as cooling_device%d\n", cdev->id);
> @@ -365,10 +427,21 @@ static int acpi_fan_probe(struct platform_device *pdev)
>         result = sysfs_create_link(&cdev->device.kobj,
>                                    &pdev->dev.kobj,
>                                    "device");
> -       if (result)
> +       if (result) {
>                 dev_err(&pdev->dev, "Failed to create sysfs link 'device'\n");
> +               goto err_end;
> +       }
> +
> +       return 0;
> +
> +err_end:
> +       if (fan->acpi4) {
> +               int i;
> +
> +               for (i = 0; i < fan->fps_count; ++i)
> +                       sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
> +       }
>
> -end:
>         return result;
>  }
>
> @@ -376,6 +449,13 @@ static int acpi_fan_remove(struct platform_device *pdev)
>  {
>         struct acpi_fan *fan = platform_get_drvdata(pdev);
>
> +       if (fan->acpi4) {
> +               struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +               int i;
> +
> +               for (i = 0; i < fan->fps_count; ++i)
> +                       sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
> +       }
>         sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
>         sysfs_remove_link(&fan->cdev->device.kobj, "device");
>         thermal_cooling_device_unregister(fan->cdev);
> --
> 2.17.2
>
