Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986E1300705
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 16:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbhAVPUM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 10:20:12 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:46032 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbhAVPTu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 10:19:50 -0500
Received: by mail-ot1-f52.google.com with SMTP id n42so5341341ota.12;
        Fri, 22 Jan 2021 07:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ru9SqLDalSol6ab84w3ZSZycnq+w3gNRzUFlTK6l04E=;
        b=TVXSTIPQ8AIrcsbeJz8ixDGAxJXAamomAOausa8jdd9J3CYcr+1g3rE6nRVS/Qb3kP
         or1Te8OTLfP4gmTRX6WudtwLKxpD7O6POW/6ZK0qVU2j6Pm+qBV1DqnSQllPe7vazqAH
         aHwpQiPAyqauk4FuEI6pymhQo7hLtM1ubZxZ8jrAay6EYQoBGxn8dJvZjyKL2Tz7ddsF
         RC7Ph2CmiJFkCmziyxK5xh2d+/hD2nmbZcj+Ymb6C2CYzuWx/IPUInz+d4yPV9ajHRw1
         RhonU0uFC5+cdY1sEBO8T8IepG+yu69F+f6KVeS/8LO//GMP1rqwUWU1SOO+Z/lwSOhv
         SM9g==
X-Gm-Message-State: AOAM532d3hOUC8+wqb3mJ1tBF5cnKuUpAIp+qsb9PH8qxtn4E6OUXmI/
        /zbeYNLcjqpWZlMqBjCM5VqfQRtXZ7PuO+fx4qg=
X-Google-Smtp-Source: ABdhPJz0loV+yYVafmhFPpKiuaGh2qJJ5YARsH5THv+/tBwBjBw8K9wW5GJ4n/RGr3c/OiELmg1Zfj/xVDmZFF0Cirk=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr3793778otk.206.1611328731667;
 Fri, 22 Jan 2021 07:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20201217124536.26812-1-dwaipayanray1@gmail.com>
In-Reply-To: <20201217124536.26812-1-dwaipayanray1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 16:18:40 +0100
Message-ID: <CAJZ5v0h0G2zRX-JCpOAZj7DwuYe1MGTSK5S+mTDg00LZktKwjw@mail.gmail.com>
Subject: Re: [PATCH] acpi: Use DEVICE_ATTR_<RW|RO|WO> macros
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 17, 2020 at 1:47 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> Instead of open coding DEVICE_ATTR(), use the
> DEVICE_ATTR_RW(), DEVICE_ATTR_RO() and DEVICE_ATTR_WO()
> macros wherever possible.
>
> This required a few functions to be renamed but the
> functionality itself is unchanged.
>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

Applied as 5.12 material, thanks!

> ---
> Note: The patch is compiled tested only.
> Merges cleanly with next-20201210
>
>  drivers/acpi/acpi_pad.c     | 24 ++++++++------------
>  drivers/acpi/acpi_tad.c     | 14 ++++++------
>  drivers/acpi/bgrt.c         | 20 ++++++++---------
>  drivers/acpi/device_sysfs.c | 44 ++++++++++++++++++-------------------
>  drivers/acpi/dock.c         | 26 +++++++++++-----------
>  drivers/acpi/power.c        |  9 ++++----
>  6 files changed, 66 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index b8745ce48a47..b84ab722feb4 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -261,7 +261,7 @@ static uint32_t acpi_pad_idle_cpus_num(void)
>         return ps_tsk_num;
>  }
>
> -static ssize_t acpi_pad_rrtime_store(struct device *dev,
> +static ssize_t rrtime_store(struct device *dev,
>         struct device_attribute *attr, const char *buf, size_t count)
>  {
>         unsigned long num;
> @@ -275,16 +275,14 @@ static ssize_t acpi_pad_rrtime_store(struct device *dev,
>         return count;
>  }
>
> -static ssize_t acpi_pad_rrtime_show(struct device *dev,
> +static ssize_t rrtime_show(struct device *dev,
>         struct device_attribute *attr, char *buf)
>  {
>         return scnprintf(buf, PAGE_SIZE, "%d\n", round_robin_time);
>  }
> -static DEVICE_ATTR(rrtime, S_IRUGO|S_IWUSR,
> -       acpi_pad_rrtime_show,
> -       acpi_pad_rrtime_store);
> +static DEVICE_ATTR_RW(rrtime);
>
> -static ssize_t acpi_pad_idlepct_store(struct device *dev,
> +static ssize_t idlepct_store(struct device *dev,
>         struct device_attribute *attr, const char *buf, size_t count)
>  {
>         unsigned long num;
> @@ -298,16 +296,14 @@ static ssize_t acpi_pad_idlepct_store(struct device *dev,
>         return count;
>  }
>
> -static ssize_t acpi_pad_idlepct_show(struct device *dev,
> +static ssize_t idlepct_show(struct device *dev,
>         struct device_attribute *attr, char *buf)
>  {
>         return scnprintf(buf, PAGE_SIZE, "%d\n", idle_pct);
>  }
> -static DEVICE_ATTR(idlepct, S_IRUGO|S_IWUSR,
> -       acpi_pad_idlepct_show,
> -       acpi_pad_idlepct_store);
> +static DEVICE_ATTR_RW(idlepct);
>
> -static ssize_t acpi_pad_idlecpus_store(struct device *dev,
> +static ssize_t idlecpus_store(struct device *dev,
>         struct device_attribute *attr, const char *buf, size_t count)
>  {
>         unsigned long num;
> @@ -319,16 +315,14 @@ static ssize_t acpi_pad_idlecpus_store(struct device *dev,
>         return count;
>  }
>
> -static ssize_t acpi_pad_idlecpus_show(struct device *dev,
> +static ssize_t idlecpus_show(struct device *dev,
>         struct device_attribute *attr, char *buf)
>  {
>         return cpumap_print_to_pagebuf(false, buf,
>                                        to_cpumask(pad_busy_cpus_bits));
>  }
>
> -static DEVICE_ATTR(idlecpus, S_IRUGO|S_IWUSR,
> -       acpi_pad_idlecpus_show,
> -       acpi_pad_idlecpus_store);
> +static DEVICE_ATTR_RW(idlecpus);
>
>  static int acpi_pad_add_sysfs(struct acpi_device *device)
>  {
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index 7d45cce0c3c1..e9b8e8305e23 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -237,7 +237,7 @@ static ssize_t time_show(struct device *dev, struct device_attribute *attr,
>                        rt.tz, rt.daylight);
>  }
>
> -static DEVICE_ATTR(time, S_IRUSR | S_IWUSR, time_show, time_store);
> +static DEVICE_ATTR_RW(time);
>
>  static struct attribute *acpi_tad_time_attrs[] = {
>         &dev_attr_time.attr,
> @@ -446,7 +446,7 @@ static ssize_t ac_alarm_show(struct device *dev, struct device_attribute *attr,
>         return acpi_tad_alarm_read(dev, buf, ACPI_TAD_AC_TIMER);
>  }
>
> -static DEVICE_ATTR(ac_alarm, S_IRUSR | S_IWUSR, ac_alarm_show, ac_alarm_store);
> +static DEVICE_ATTR_RW(ac_alarm);
>
>  static ssize_t ac_policy_store(struct device *dev, struct device_attribute *attr,
>                                const char *buf, size_t count)
> @@ -462,7 +462,7 @@ static ssize_t ac_policy_show(struct device *dev, struct device_attribute *attr,
>         return acpi_tad_policy_read(dev, buf, ACPI_TAD_AC_TIMER);
>  }
>
> -static DEVICE_ATTR(ac_policy, S_IRUSR | S_IWUSR, ac_policy_show, ac_policy_store);
> +static DEVICE_ATTR_RW(ac_policy);
>
>  static ssize_t ac_status_store(struct device *dev, struct device_attribute *attr,
>                                const char *buf, size_t count)
> @@ -478,7 +478,7 @@ static ssize_t ac_status_show(struct device *dev, struct device_attribute *attr,
>         return acpi_tad_status_read(dev, buf, ACPI_TAD_AC_TIMER);
>  }
>
> -static DEVICE_ATTR(ac_status, S_IRUSR | S_IWUSR, ac_status_show, ac_status_store);
> +static DEVICE_ATTR_RW(ac_status);
>
>  static struct attribute *acpi_tad_attrs[] = {
>         &dev_attr_caps.attr,
> @@ -505,7 +505,7 @@ static ssize_t dc_alarm_show(struct device *dev, struct device_attribute *attr,
>         return acpi_tad_alarm_read(dev, buf, ACPI_TAD_DC_TIMER);
>  }
>
> -static DEVICE_ATTR(dc_alarm, S_IRUSR | S_IWUSR, dc_alarm_show, dc_alarm_store);
> +static DEVICE_ATTR_RW(dc_alarm);
>
>  static ssize_t dc_policy_store(struct device *dev, struct device_attribute *attr,
>                                const char *buf, size_t count)
> @@ -521,7 +521,7 @@ static ssize_t dc_policy_show(struct device *dev, struct device_attribute *attr,
>         return acpi_tad_policy_read(dev, buf, ACPI_TAD_DC_TIMER);
>  }
>
> -static DEVICE_ATTR(dc_policy, S_IRUSR | S_IWUSR, dc_policy_show, dc_policy_store);
> +static DEVICE_ATTR_RW(dc_policy);
>
>  static ssize_t dc_status_store(struct device *dev, struct device_attribute *attr,
>                                const char *buf, size_t count)
> @@ -537,7 +537,7 @@ static ssize_t dc_status_show(struct device *dev, struct device_attribute *attr,
>         return acpi_tad_status_read(dev, buf, ACPI_TAD_DC_TIMER);
>  }
>
> -static DEVICE_ATTR(dc_status, S_IRUSR | S_IWUSR, dc_status_show, dc_status_store);
> +static DEVICE_ATTR_RW(dc_status);
>
>  static struct attribute *acpi_tad_dc_attrs[] = {
>         &dev_attr_dc_alarm.attr,
> diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
> index 251f961c28cc..19bb7f870204 100644
> --- a/drivers/acpi/bgrt.c
> +++ b/drivers/acpi/bgrt.c
> @@ -15,40 +15,40 @@
>  static void *bgrt_image;
>  static struct kobject *bgrt_kobj;
>
> -static ssize_t show_version(struct device *dev,
> +static ssize_t version_show(struct device *dev,
>                             struct device_attribute *attr, char *buf)
>  {
>         return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab.version);
>  }
> -static DEVICE_ATTR(version, S_IRUGO, show_version, NULL);
> +static DEVICE_ATTR_RO(version);
>
> -static ssize_t show_status(struct device *dev,
> +static ssize_t status_show(struct device *dev,
>                            struct device_attribute *attr, char *buf)
>  {
>         return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab.status);
>  }
> -static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
> +static DEVICE_ATTR_RO(status);
>
> -static ssize_t show_type(struct device *dev,
> +static ssize_t type_show(struct device *dev,
>                          struct device_attribute *attr, char *buf)
>  {
>         return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab.image_type);
>  }
> -static DEVICE_ATTR(type, S_IRUGO, show_type, NULL);
> +static DEVICE_ATTR_RO(type);
>
> -static ssize_t show_xoffset(struct device *dev,
> +static ssize_t xoffset_show(struct device *dev,
>                             struct device_attribute *attr, char *buf)
>  {
>         return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab.image_offset_x);
>  }
> -static DEVICE_ATTR(xoffset, S_IRUGO, show_xoffset, NULL);
> +static DEVICE_ATTR_RO(xoffset);
>
> -static ssize_t show_yoffset(struct device *dev,
> +static ssize_t yoffset_show(struct device *dev,
>                             struct device_attribute *attr, char *buf)
>  {
>         return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab.image_offset_y);
>  }
> -static DEVICE_ATTR(yoffset, S_IRUGO, show_yoffset, NULL);
> +static DEVICE_ATTR_RO(yoffset);
>
>  static ssize_t image_read(struct file *file, struct kobject *kobj,
>                struct bin_attribute *attr, char *buf, loff_t off, size_t count)
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 96869f1538b9..a25f108240e4 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -333,11 +333,11 @@ int acpi_device_modalias(struct device *dev, char *buf, int size)
>  EXPORT_SYMBOL_GPL(acpi_device_modalias);
>
>  static ssize_t
> -acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
> +modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>         return __acpi_device_modalias(to_acpi_device(dev), buf, 1024);
>  }
> -static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
> +static DEVICE_ATTR_RO(modalias);
>
>  static ssize_t real_power_state_show(struct device *dev,
>                                      struct device_attribute *attr, char *buf)
> @@ -366,8 +366,8 @@ static ssize_t power_state_show(struct device *dev,
>  static DEVICE_ATTR_RO(power_state);
>
>  static ssize_t
> -acpi_eject_store(struct device *d, struct device_attribute *attr,
> -               const char *buf, size_t count)
> +eject_store(struct device *d, struct device_attribute *attr,
> +           const char *buf, size_t count)
>  {
>         struct acpi_device *acpi_device = to_acpi_device(d);
>         acpi_object_type not_used;
> @@ -395,28 +395,28 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
>         return status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
>  }
>
> -static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
> +static DEVICE_ATTR_WO(eject);
>
>  static ssize_t
> -acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf)
> +hid_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>         struct acpi_device *acpi_dev = to_acpi_device(dev);
>
>         return sprintf(buf, "%s\n", acpi_device_hid(acpi_dev));
>  }
> -static DEVICE_ATTR(hid, 0444, acpi_device_hid_show, NULL);
> +static DEVICE_ATTR_RO(hid);
>
> -static ssize_t acpi_device_uid_show(struct device *dev,
> -                                   struct device_attribute *attr, char *buf)
> +static ssize_t uid_show(struct device *dev,
> +                       struct device_attribute *attr, char *buf)
>  {
>         struct acpi_device *acpi_dev = to_acpi_device(dev);
>
>         return sprintf(buf, "%s\n", acpi_dev->pnp.unique_id);
>  }
> -static DEVICE_ATTR(uid, 0444, acpi_device_uid_show, NULL);
> +static DEVICE_ATTR_RO(uid);
>
> -static ssize_t acpi_device_adr_show(struct device *dev,
> -                                   struct device_attribute *attr, char *buf)
> +static ssize_t adr_show(struct device *dev,
> +                       struct device_attribute *attr, char *buf)
>  {
>         struct acpi_device *acpi_dev = to_acpi_device(dev);
>
> @@ -425,16 +425,16 @@ static ssize_t acpi_device_adr_show(struct device *dev,
>         else
>                 return sprintf(buf, "0x%08llx\n", acpi_dev->pnp.bus_address);
>  }
> -static DEVICE_ATTR(adr, 0444, acpi_device_adr_show, NULL);
> +static DEVICE_ATTR_RO(adr);
>
> -static ssize_t acpi_device_path_show(struct device *dev,
> -                                    struct device_attribute *attr, char *buf)
> +static ssize_t path_show(struct device *dev,
> +                        struct device_attribute *attr, char *buf)
>  {
>         struct acpi_device *acpi_dev = to_acpi_device(dev);
>
>         return acpi_object_path(acpi_dev->handle, buf);
>  }
> -static DEVICE_ATTR(path, 0444, acpi_device_path_show, NULL);
> +static DEVICE_ATTR_RO(path);
>
>  /* sysfs file that shows description text from the ACPI _STR method */
>  static ssize_t description_show(struct device *dev,
> @@ -463,8 +463,8 @@ static ssize_t description_show(struct device *dev,
>  static DEVICE_ATTR_RO(description);
>
>  static ssize_t
> -acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
> -                    char *buf) {
> +sun_show(struct device *dev, struct device_attribute *attr,
> +        char *buf) {
>         struct acpi_device *acpi_dev = to_acpi_device(dev);
>         acpi_status status;
>         unsigned long long sun;
> @@ -475,11 +475,11 @@ acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
>
>         return sprintf(buf, "%llu\n", sun);
>  }
> -static DEVICE_ATTR(sun, 0444, acpi_device_sun_show, NULL);
> +static DEVICE_ATTR_RO(sun);
>
>  static ssize_t
> -acpi_device_hrv_show(struct device *dev, struct device_attribute *attr,
> -                    char *buf) {
> +hrv_show(struct device *dev, struct device_attribute *attr,
> +        char *buf) {
>         struct acpi_device *acpi_dev = to_acpi_device(dev);
>         acpi_status status;
>         unsigned long long hrv;
> @@ -490,7 +490,7 @@ acpi_device_hrv_show(struct device *dev, struct device_attribute *attr,
>
>         return sprintf(buf, "%llu\n", hrv);
>  }
> -static DEVICE_ATTR(hrv, 0444, acpi_device_hrv_show, NULL);
> +static DEVICE_ATTR_RO(hrv);
>
>  static ssize_t status_show(struct device *dev, struct device_attribute *attr,
>                                 char *buf) {
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index 24e076f44d23..0937ceab052e 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -484,7 +484,7 @@ int dock_notify(struct acpi_device *adev, u32 event)
>  /*
>   * show_docked - read method for "docked" file in sysfs
>   */
> -static ssize_t show_docked(struct device *dev,
> +static ssize_t docked_show(struct device *dev,
>                            struct device_attribute *attr, char *buf)
>  {
>         struct dock_station *dock_station = dev->platform_data;
> @@ -493,25 +493,25 @@ static ssize_t show_docked(struct device *dev,
>         acpi_bus_get_device(dock_station->handle, &adev);
>         return snprintf(buf, PAGE_SIZE, "%u\n", acpi_device_enumerated(adev));
>  }
> -static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
> +static DEVICE_ATTR_RO(docked);
>
>  /*
>   * show_flags - read method for flags file in sysfs
>   */
> -static ssize_t show_flags(struct device *dev,
> +static ssize_t flags_show(struct device *dev,
>                           struct device_attribute *attr, char *buf)
>  {
>         struct dock_station *dock_station = dev->platform_data;
>         return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
>
>  }
> -static DEVICE_ATTR(flags, S_IRUGO, show_flags, NULL);
> +static DEVICE_ATTR_RO(flags);
>
>  /*
>   * write_undock - write method for "undock" file in sysfs
>   */
> -static ssize_t write_undock(struct device *dev, struct device_attribute *attr,
> -                          const char *buf, size_t count)
> +static ssize_t undock_store(struct device *dev, struct device_attribute *attr,
> +                           const char *buf, size_t count)
>  {
>         int ret;
>         struct dock_station *dock_station = dev->platform_data;
> @@ -525,13 +525,13 @@ static ssize_t write_undock(struct device *dev, struct device_attribute *attr,
>         acpi_scan_lock_release();
>         return ret ? ret: count;
>  }
> -static DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
> +static DEVICE_ATTR_WO(undock);
>
>  /*
>   * show_dock_uid - read method for "uid" file in sysfs
>   */
> -static ssize_t show_dock_uid(struct device *dev,
> -                            struct device_attribute *attr, char *buf)
> +static ssize_t uid_show(struct device *dev,
> +                       struct device_attribute *attr, char *buf)
>  {
>         unsigned long long lbuf;
>         struct dock_station *dock_station = dev->platform_data;
> @@ -542,10 +542,10 @@ static ssize_t show_dock_uid(struct device *dev,
>
>         return snprintf(buf, PAGE_SIZE, "%llx\n", lbuf);
>  }
> -static DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
> +static DEVICE_ATTR_RO(uid);
>
> -static ssize_t show_dock_type(struct device *dev,
> -               struct device_attribute *attr, char *buf)
> +static ssize_t type_show(struct device *dev,
> +                        struct device_attribute *attr, char *buf)
>  {
>         struct dock_station *dock_station = dev->platform_data;
>         char *type;
> @@ -561,7 +561,7 @@ static ssize_t show_dock_type(struct device *dev,
>
>         return snprintf(buf, PAGE_SIZE, "%s\n", type);
>  }
> -static DEVICE_ATTR(type, S_IRUGO, show_dock_type, NULL);
> +static DEVICE_ATTR_RO(type);
>
>  static struct attribute *dock_attributes[] = {
>         &dev_attr_docked.attr,
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 189a0d4c6d06..3a7d0d703059 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -886,15 +886,16 @@ static void acpi_release_power_resource(struct device *dev)
>         kfree(resource);
>  }
>
> -static ssize_t acpi_power_in_use_show(struct device *dev,
> -                                     struct device_attribute *attr,
> -                                     char *buf) {
> +static ssize_t resource_in_use_show(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   char *buf)
> +{
>         struct acpi_power_resource *resource;
>
>         resource = to_power_resource(to_acpi_device(dev));
>         return sprintf(buf, "%u\n", !!resource->ref_count);
>  }
> -static DEVICE_ATTR(resource_in_use, 0444, acpi_power_in_use_show, NULL);
> +static DEVICE_ATTR_RO(resource_in_use);
>
>  static void acpi_power_sysfs_remove(struct acpi_device *device)
>  {
> --
> 2.27.0
>
