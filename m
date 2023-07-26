Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6706E764074
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jul 2023 22:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGZUYG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jul 2023 16:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGZUYF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2023 16:24:05 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 13:24:03 PDT
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCDEC0
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jul 2023 13:24:03 -0700 (PDT)
Received: from [192.168.0.22] (unknown [50.47.218.115])
        by endrift.com (Postfix) with ESMTPSA id 6DC03A248;
        Wed, 26 Jul 2023 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
        t=1690402642; bh=eKU+b+GTRZYOaGCipZ2PMsmGSqcWOyQyZxlJwCCV0BE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eMkwRqBn5dUYnBmsjCW1UpVR2MSRYwNpw2/QcZyJ73/q42AuBMrczQ2wfp4gyRIdP
         Z1TZ3QTyI79/ljJCbiqr/phhqG+S6askRaB7gbG3ejRKoQEoz0uLbGjCU/Lt6LEztp
         pthV0q+uspBfz7uorZauFJsm/sh48wiS6kXNM1DhaQr41vWafyePjDrwgHkMKfT9bA
         hEzel47hkzGQGGqIsfy5MLV2XI+ulEBK3VJQ30xVRAVOc8hpiIk8EQvmOk09tQR0ss
         mVFISZa3CFeGBycTw2JwFWmDY2rUa+XbOVe6m68vCKHhDtA4K5QbXORvlighw/sw5e
         3w5ZUzdruO8+A==
Message-ID: <f8989816-a49b-23b2-5a15-952109174102@endrift.com>
Date:   Wed, 26 Jul 2023 13:17:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: utils: Make acpi_handle_list dynamically allocated
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
References: <20230330030446.2469338-1-vi@endrift.com>
 <CAJZ5v0gk_qByM6uNiBtjgj3fxuXawurBB9zJ_e6Lo7b9srJ21w@mail.gmail.com>
From:   Vicki Pfau <vi@endrift.com>
In-Reply-To: <CAJZ5v0gk_qByM6uNiBtjgj3fxuXawurBB9zJ_e6Lo7b9srJ21w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

Not sure how I missed this reply. Sorry for the delay.

On 4/20/23 08:46, Rafael J. Wysocki wrote:
> On Thu, Mar 30, 2023 at 5:13 AM Vicki Pfau <vi@endrift.com> wrote:
>>
>> This fixes a long-standing "TBD" comment in the ACPI headers regarding making
>> the acpi_handle_list struct's size dynamic. The number 10, which along with the
>> comment dates back to 2.4.23, seems like it may have been arbitrarily chosen,
>> and isn't sufficient in all cases. This patch finally makes the size dynamic
>> and updates its users to handle the modified API.
>>
>> Signed-off-by: Vicki Pfau <vi@endrift.com>
>> ---
>>  drivers/acpi/acpi_lpss.c                      |  9 ++--
>>  drivers/acpi/scan.c                           |  9 ++--
>>  drivers/acpi/thermal.c                        | 54 +++++++++++--------
>>  drivers/acpi/utils.c                          | 14 ++---
>>  .../platform/surface/surface_acpi_notify.c    |  9 ++--
>>  include/acpi/acpi_bus.h                       | 18 +++++--
>>  6 files changed, 71 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
>> index f08ffa75f4a7..5aebd338943f 100644
>> --- a/drivers/acpi/acpi_lpss.c
>> +++ b/drivers/acpi/acpi_lpss.c
>> @@ -561,7 +561,7 @@ static struct device *acpi_lpss_find_device(const char *hid, const char *uid)
>>
>>  static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
>>  {
>> -       struct acpi_handle_list dep_devices;
>> +       struct acpi_handle_list *dep_devices;
>>         acpi_status status;
>>         int i;
>>
>> @@ -575,11 +575,14 @@ static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
>>                 return false;
>>         }
>>
>> -       for (i = 0; i < dep_devices.count; i++) {
>> -               if (dep_devices.handles[i] == handle)
>> +       for (i = 0; i < dep_devices->count; i++) {
>> +               if (dep_devices->handles[i] == handle) {
>> +                       kfree(dep_devices);
>>                         return true;
>> +               }
>>         }
>>
>> +       kfree(dep_devices);
>>         return false;
>>  }
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 0c6f06abe3f4..167423b68f83 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1972,7 +1972,7 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
>>
>>  static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
>>  {
>> -       struct acpi_handle_list dep_devices;
>> +       struct acpi_handle_list *dep_devices;
>>         acpi_status status;
>>         u32 count;
>>         int i;
>> @@ -1993,12 +1993,12 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
>>                 return 0;
>>         }
>>
>> -       for (count = 0, i = 0; i < dep_devices.count; i++) {
>> +       for (count = 0, i = 0; i < dep_devices->count; i++) {
>>                 struct acpi_device_info *info;
>>                 struct acpi_dep_data *dep;
>>                 bool skip, honor_dep;
>>
>> -               status = acpi_get_object_info(dep_devices.handles[i], &info);
>> +               status = acpi_get_object_info(dep_devices->handles[i], &info);
>>                 if (ACPI_FAILURE(status)) {
>>                         acpi_handle_debug(handle, "Error reading _DEP device info\n");
>>                         continue;
>> @@ -2017,7 +2017,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
>>
>>                 count++;
>>
>> -               dep->supplier = dep_devices.handles[i];
>> +               dep->supplier = dep_devices->handles[i];
>>                 dep->consumer = handle;
>>                 dep->honor_dep = honor_dep;
>>
>> @@ -2026,6 +2026,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
>>                 mutex_unlock(&acpi_dep_list_lock);
>>         }
>>
>> +       kfree(dep_devices);
>>         return count;
>>  }
>>
>> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
>> index 0b4b844f9d4c..132b206cd4e6 100644
>> --- a/drivers/acpi/thermal.c
>> +++ b/drivers/acpi/thermal.c
>> @@ -135,13 +135,13 @@ struct acpi_thermal_passive {
>>         unsigned long tc1;
>>         unsigned long tc2;
>>         unsigned long tsp;
>> -       struct acpi_handle_list devices;
>> +       struct acpi_handle_list *devices;
>>  };
>>
>>  struct acpi_thermal_active {
>>         struct acpi_thermal_state_flags flags;
>>         unsigned long temperature;
>> -       struct acpi_handle_list devices;
>> +       struct acpi_handle_list *devices;
>>  };
>>
>>  struct acpi_thermal_trips {
>> @@ -167,7 +167,7 @@ struct acpi_thermal {
>>         struct acpi_thermal_flags flags;
>>         struct acpi_thermal_state state;
>>         struct acpi_thermal_trips trips;
>> -       struct acpi_handle_list devices;
>> +       struct acpi_handle_list *devices;
>>         struct thermal_zone_device *thermal_zone;
>>         int kelvin_offset;      /* in millidegrees */
>>         struct work_struct thermal_check_work;
>> @@ -264,7 +264,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>>  {
>>         acpi_status status;
>>         unsigned long long tmp;
>> -       struct acpi_handle_list devices;
>> +       struct acpi_handle_list *devices;
>>         int valid = 0;
>>         int i;
>>
>> @@ -368,7 +368,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>>                 }
>>         }
>>         if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.passive.flags.valid) {
>> -               memset(&devices, 0, sizeof(struct acpi_handle_list));
>> +               devices = NULL;
>>                 status = acpi_evaluate_reference(tz->device->handle, "_PSL",
>>                                                  NULL, &devices);
>>                 if (ACPI_FAILURE(status)) {
>> @@ -379,11 +379,12 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>>                         tz->trips.passive.flags.valid = 1;
>>                 }
>>
>> -               if (memcmp(&tz->trips.passive.devices, &devices,
>> -                          sizeof(struct acpi_handle_list))) {
>> -                       memcpy(&tz->trips.passive.devices, &devices,
>> -                              sizeof(struct acpi_handle_list));
>> +               if (!acpi_handle_list_equal(tz->trips.passive.devices, devices)) {
>> +                       kfree(tz->trips.passive.devices);
>> +                       tz->trips.passive.devices = devices;
>>                         ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
>> +               } else if (devices) {
>> +                       kfree(devices);
>>                 }
>>         }
>>         if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
>> @@ -433,7 +434,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>>
>>                 name[2] = 'L';
>>                 if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].flags.valid) {
>> -                       memset(&devices, 0, sizeof(struct acpi_handle_list));
>> +                       devices = NULL;
>>                         status = acpi_evaluate_reference(tz->device->handle,
>>                                                          name, NULL, &devices);
>>                         if (ACPI_FAILURE(status)) {
>> @@ -444,11 +445,12 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>>                                 tz->trips.active[i].flags.valid = 1;
>>                         }
>>
>> -                       if (memcmp(&tz->trips.active[i].devices, &devices,
>> -                                  sizeof(struct acpi_handle_list))) {
>> -                               memcpy(&tz->trips.active[i].devices, &devices,
>> -                                      sizeof(struct acpi_handle_list));
>> +                       if (!acpi_handle_list_equal(tz->trips.active[i].devices, devices)) {
>> +                               kfree(tz->trips.active[i].devices);
>> +                               tz->trips.active[i].devices = devices;
>>                                 ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
>> +                       } else if (devices) {
>> +                               kfree(devices);
>>                         }
>>                 }
>>                 if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
>> @@ -460,13 +462,16 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>>         }
>>
>>         if (flag & ACPI_TRIPS_DEVICES) {
>> -               memset(&devices, 0, sizeof(devices));
>> +               devices = NULL;
>>                 status = acpi_evaluate_reference(tz->device->handle, "_TZD",
>>                                                  NULL, &devices);
>>                 if (ACPI_SUCCESS(status) &&
>> -                   memcmp(&tz->devices, &devices, sizeof(devices))) {
>> +                   !acpi_handle_list_equal(tz->devices, devices)) {
>> +                       kfree(tz->devices);
>>                         tz->devices = devices;
>>                         ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
>> +               } else if (devices) {
>> +                       kfree(devices);
>>                 }
>>         }
>>
>> @@ -709,8 +714,8 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
>>
>>         if (tz->trips.passive.flags.valid) {
>>                 trip++;
>> -               for (i = 0; i < tz->trips.passive.devices.count; i++) {
>> -                       handle = tz->trips.passive.devices.handles[i];
>> +               for (i = 0; i < tz->trips.passive.devices->count; i++) {
>> +                       handle = tz->trips.passive.devices->handles[i];
>>                         dev = acpi_fetch_acpi_dev(handle);
>>                         if (dev != device)
>>                                 continue;
>> @@ -736,8 +741,8 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
>>                         break;
>>
>>                 trip++;
>> -               for (j = 0; j < tz->trips.active[i].devices.count; j++) {
>> -                       handle = tz->trips.active[i].devices.handles[j];
>> +               for (j = 0; j < tz->trips.active[i].devices->count; j++) {
>> +                       handle = tz->trips.active[i].devices->handles[j];
>>                         dev = acpi_fetch_acpi_dev(handle);
>>                         if (dev != device)
>>                                 continue;
>> @@ -1062,6 +1067,7 @@ static int acpi_thermal_add(struct acpi_device *device)
>>  static void acpi_thermal_remove(struct acpi_device *device)
>>  {
>>         struct acpi_thermal *tz;
>> +       int i;
>>
>>         if (!device || !acpi_driver_data(device))
>>                 return;
>> @@ -1070,6 +1076,10 @@ static void acpi_thermal_remove(struct acpi_device *device)
>>         tz = acpi_driver_data(device);
>>
>>         acpi_thermal_unregister_thermal_zone(tz);
>> +       kfree(tz->trips.passive.devices);
>> +       for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
>> +               kfree(tz->trips.active[i].devices);
>> +       kfree(tz->devices);
>>         kfree(tz);
>>  }
>>
>> @@ -1098,9 +1108,9 @@ static int acpi_thermal_resume(struct device *dev)
>>                         break;
>>
>>                 tz->trips.active[i].flags.enabled = 1;
>> -               for (j = 0; j < tz->trips.active[i].devices.count; j++) {
>> +               for (j = 0; j < tz->trips.active[i].devices->count; j++) {
>>                         result = acpi_bus_update_power(
>> -                                       tz->trips.active[i].devices.handles[j],
>> +                                       tz->trips.active[i].devices->handles[j],
>>                                         &power_state);
>>                         if (result || (power_state != ACPI_STATE_D0)) {
>>                                 tz->trips.active[i].flags.enabled = 0;
>> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
>> index 2ea14648a661..dd76389ede96 100644
>> --- a/drivers/acpi/utils.c
>> +++ b/drivers/acpi/utils.c
>> @@ -333,16 +333,17 @@ acpi_status
>>  acpi_evaluate_reference(acpi_handle handle,
>>                         acpi_string pathname,
>>                         struct acpi_object_list *arguments,
>> -                       struct acpi_handle_list *list)
>> +                       struct acpi_handle_list **out)
>>  {
>>         acpi_status status = AE_OK;
>> +       struct acpi_handle_list *list = NULL;
>>         union acpi_object *package = NULL;
>>         union acpi_object *element = NULL;
>>         struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>>         u32 i = 0;
>>
>>
>> -       if (!list) {
>> +       if (!out) {
>>                 return AE_BAD_PARAMETER;
>>         }
>>
>> @@ -370,7 +371,8 @@ acpi_evaluate_reference(acpi_handle handle,
>>                 goto end;
>>         }
>>
>> -       if (package->package.count > ACPI_MAX_HANDLES) {
>> +       list = kmalloc(package->package.count * sizeof(list->handles[0]) + sizeof(*list), GFP_KERNEL);
>> +       if (!list) {
>>                 kfree(package);
>>                 return AE_NO_MEMORY;
>>         }
>> @@ -400,12 +402,12 @@ acpi_evaluate_reference(acpi_handle handle,
>>         }
>>
>>        end:
>> -       if (ACPI_FAILURE(status)) {
>> -               list->count = 0;
>> -               //kfree(list->handles);
>> +       if (ACPI_FAILURE(status) && list) {
>> +               kfree(list);
>>         }
>>
>>         kfree(buffer.pointer);
>> +       *out = list;
>>
>>         return status;
>>  }
>> diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
>> index 897cdd9c3aae..c6ead68cefc9 100644
>> --- a/drivers/platform/surface/surface_acpi_notify.c
>> +++ b/drivers/platform/surface/surface_acpi_notify.c
>> @@ -738,7 +738,7 @@ do {                                                                                \
>>
>>  static bool is_san_consumer(struct platform_device *pdev, acpi_handle handle)
>>  {
>> -       struct acpi_handle_list dep_devices;
>> +       struct acpi_handle_list *dep_devices;
>>         acpi_handle supplier = ACPI_HANDLE(&pdev->dev);
>>         acpi_status status;
>>         int i;
>> @@ -752,11 +752,14 @@ static bool is_san_consumer(struct platform_device *pdev, acpi_handle handle)
>>                 return false;
>>         }
>>
>> -       for (i = 0; i < dep_devices.count; i++) {
>> -               if (dep_devices.handles[i] == supplier)
>> +       for (i = 0; i < dep_devices->count; i++) {
>> +               if (dep_devices->handles[i] == supplier) {
>> +                       kfree(dep_devices);
>>                         return true;
>> +               }
>>         }
>>
>> +       kfree(dep_devices);
>>         return false;
>>  }
>>
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 57acb895c038..8684efcf0e17 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -12,11 +12,9 @@
>>  #include <linux/device.h>
>>  #include <linux/property.h>
>>
>> -/* TBD: Make dynamic */
>> -#define ACPI_MAX_HANDLES       10
>>  struct acpi_handle_list {
>>         u32 count;
>> -       acpi_handle handles[ACPI_MAX_HANDLES];
>> +       acpi_handle handles[];
> 
> Can you just use
> 
> acpi_handle *handles;
> 
> here, in which case you won't need to change all of the struct
> acpi_handle_list variables into pointers?
> 

My original version of this patch that was used internally did this, but it was pointed out during review that this made the API slightly messier due to the fact you needed to free a specific member of the handle list instead of being able to just free the whole struct, as well as making comparison of two structs much more verbose.

Overall, this version is cleaner than the original version, but it does require changing types in places. I can go back to the old version and resubmit if desired though.

>>  };
>>
>>  /* acpi_utils.h */
>> @@ -31,7 +29,7 @@ acpi_status
>>  acpi_evaluate_reference(acpi_handle handle,
>>                         acpi_string pathname,
>>                         struct acpi_object_list *arguments,
>> -                       struct acpi_handle_list *list);
>> +                       struct acpi_handle_list **list);
>>  acpi_status
>>  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
>>                   struct acpi_buffer *status_buf);
>> @@ -69,6 +67,18 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
>>         return obj;
>>  }
>>
>> +static inline bool
>> +acpi_handle_list_equal(struct acpi_handle_list *a, struct acpi_handle_list *b)
>> +{
>> +       if (!a || !b)
>> +               return false;
>> +
>> +       if (a->count != b->count)
>> +               return false;
>> +
>> +       return !memcmp(a->handles, b->handles, a->count * sizeof(acpi_handle));
>> +}
>> +
>>  #define        ACPI_INIT_DSM_ARGV4(cnt, eles)                  \
>>         {                                               \
>>           .package.type = ACPI_TYPE_PACKAGE,            \
>> --
>> 2.40.0
>>

Vicki
