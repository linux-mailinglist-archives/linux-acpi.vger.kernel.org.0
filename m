Return-Path: <linux-acpi+bounces-10193-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC2A9F7D57
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 15:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58B0169260
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0C86349;
	Thu, 19 Dec 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpx60iSL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D7D78F2A;
	Thu, 19 Dec 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619791; cv=none; b=pKl7Mk+k7dbIuxqYLrHoYdhSrSYvydfZW/Bil+R2wQpGt8l/T2t+2W3TytAVroh3UyQlVyUDA4Eu3QZT9P1K/PY/CtWnaTS5LFCLXEN9rQQ+TJ8O8q3KGiJWVeeOAHf0C49+V5EX9EdLlWOHgfDJLxgxDS4ppNFtkyACVfiM/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619791; c=relaxed/simple;
	bh=D4HGhhaz6x5Ojv478y5OG8tgiWNS97cMEjlajQwzTVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KN0BYy0YPag/wnDg1e07nR0u8YmpRUHHmiCApy/o/C2HeT5IocKsQVkwP8zSA6BEc9ECyGFv5kAdWsm+NTcKAGZLh5eSjx6xoof8KiBTGo/UHyMdEo9sAcQ108E25lVmO8BcwOZIkc0Ce5+ikNuSKTgzd1I1eIyDGNl/C4UKMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpx60iSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F9DC4CECE;
	Thu, 19 Dec 2024 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734619791;
	bh=D4HGhhaz6x5Ojv478y5OG8tgiWNS97cMEjlajQwzTVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rpx60iSLgDtQVyYhgDxMQd622seaCxqGeIWiJAhaPowkdZ8BqakmvagdLftKhrXkK
	 MEFO+lAQGsDPoqBT5J8dJfiJlLWua9tFm58DDloNJHVlHgPYCIpdFqK9f3uR1ut8QX
	 GeLd71UFwyPMvWKDniii6JllRelWV5HXPhYNFCEEa4tuQmbUAmhY+W++VOhduKORqA
	 /lxNb4P8csRHhuAlCSnCEbkJ7YZxhIfrkQOKliG3BYfDtLQF1YuoXBjBMyCI+YoHTL
	 D9NUidpFZM3PO6tdYZrlzaYpErmUHAML0BLlbANdwu9mHLQIBgy9fdaCjaiapaldI4
	 qNPXDCdn3Iy0g==
Message-ID: <ba5a7961-de65-41a1-a556-338ed1b06faa@kernel.org>
Date: Thu, 19 Dec 2024 08:49:47 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] platform/x86/amd: pmf: Add manual control support
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>, Mark Pearson
 <mpearson-lenovo@squebb.ca>,
 "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240926025955.1728766-1-superm1@kernel.org>
 <20240926025955.1728766-3-superm1@kernel.org>
 <CAGwozwFjo4uSFpCAXRKivK+VoeYz-Qftmw+iLtOrVnyhn3xpfA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwFjo4uSFpCAXRKivK+VoeYz-Qftmw+iLtOrVnyhn3xpfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/2024 07:12, Antheas Kapenekakis wrote:
> Hi Mario,
> given that there is a Legion Go driver in the works, and Asus already
> has a driver, the only thing that would be left for locking down ACPI
> access is manufacturers w/o vendor APIs.
> 
> So, can we restart the conversation about this driver? It would be
> nice to get to a place where we can lock down /dev/mem and ACPI by
> spring.

As Shyam mentioned we don't have control for limits by the PMF driver 
for this on PMF v2 (Strix) or later platforms.

So if we were to revive this custom discussion it would only be for 
Phoenix and Hawk Point platforms.

> 
> Moreover, since the other two proposed drivers use the
> firmware_attributes API, should this be used here as well?

I do feel that if we revive this conversation specifically for Phoenix 
and Hawk Point platforms yes we should use the same API to expose it to 
userspace as those other two drivers do.

I'd like Shyam's temperature on this idea though before anyone spends 
time on it.  If he's amenable would you want to work on it?

> 
> By the way, you were right about needing a taint for this. Strix Point
> fails to enter a lower power state during sleep if you set it to lower
> than 10W. This is not ideal, as hawk point could go down to 5 while
> still showing a power difference, but I am unsure where this bug
> should be reported. This is both through ryzenadj/ALIB

Who is to say this is a bug?  Abusing a debugging interface with a 
reverse engineered tool means you might be able to configure a platform 
out of specifications.

> 
> Antheas
> 
> On Thu, 26 Sept 2024 at 05:00, Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> A number of users resort to using reverse engineered software like
>> ryzenadj to manipulate debugging interfaces for modifying APU settings.
>>
>> At a glance these tools are useful, but the problem is they break
>> state machines in other software such as the PMF driver or the OEM
>> EC.
>>
>> Offer a knob for PMF to allow 'manual control' which will users can
>> directly change things like fPPT and sPPT. As this can be harmful for
>> a system to try to push limits outside of a thermal design, taint the
>> kernel and show a critical message when in use.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   Documentation/ABI/testing/sysfs-amd-pmf | 10 +++
>>   drivers/platform/x86/amd/pmf/Makefile   |  1 +
>>   drivers/platform/x86/amd/pmf/core.c     |  9 +++
>>   drivers/platform/x86/amd/pmf/manual.c   | 88 +++++++++++++++++++++++++
>>   drivers/platform/x86/amd/pmf/pmf.h      |  5 ++
>>   drivers/platform/x86/amd/pmf/sps.c      |  4 ++
>>   6 files changed, 117 insertions(+)
>>   create mode 100644 drivers/platform/x86/amd/pmf/manual.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-amd-pmf b/Documentation/ABI/testing/sysfs-amd-pmf
>> index 7fc0e1c2b76b..6f3d5cbf443f 100644
>> --- a/Documentation/ABI/testing/sysfs-amd-pmf
>> +++ b/Documentation/ABI/testing/sysfs-amd-pmf
>> @@ -11,3 +11,13 @@ Description: Reading this file tells if the AMD Platform Management(PMF)
>>                  To turn off CnQF user can write "off" to the sysfs node.
>>                  Note: Systems that support auto mode will not have this sysfs file
>>                  available.
>> +
>> +What:          /sys/devices/platform/*/{spl, fppt, sppt, sppt_apu_only, stt_min, stt_limit_apu, stt_skip_temp}
>> +Date:          December 2024
>> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
>> +Description:   Manual control of AMD PMF APU coefficients
>> +               .
>> +               These files are used to manually control the APU coefficients.
>> +               In order to write to these files the module most be
>> +               loaded with manual_control=1 and the user must write "custom"
>> +               to the ACPI platform profile.
>> diff --git a/drivers/platform/x86/amd/pmf/Makefile b/drivers/platform/x86/amd/pmf/Makefile
>> index 7d6079b02589..81444d6f4428 100644
>> --- a/drivers/platform/x86/amd/pmf/Makefile
>> +++ b/drivers/platform/x86/amd/pmf/Makefile
>> @@ -7,4 +7,5 @@
>>   obj-$(CONFIG_AMD_PMF) += amd-pmf.o
>>   amd-pmf-objs := core.o acpi.o sps.o \
>>                  auto-mode.o cnqf.o \
>> +               manual.o \
>>                  tee-if.o spc.o pmf-quirks.o
>> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
>> index d6af0ca036f1..52a68ca094be 100644
>> --- a/drivers/platform/x86/amd/pmf/core.c
>> +++ b/drivers/platform/x86/amd/pmf/core.c
>> @@ -53,6 +53,10 @@ static bool force_load;
>>   module_param(force_load, bool, 0444);
>>   MODULE_PARM_DESC(force_load, "Force load this driver on supported older platforms (experimental)");
>>
>> +bool pmf_manual_control;
>> +module_param_named(manual_control, pmf_manual_control, bool, 0444);
>> +MODULE_PARM_DESC(manual_control, "Expose manual control knobs (experimental)");
>> +
>>   static int amd_pmf_pwr_src_notify_call(struct notifier_block *nb, unsigned long event, void *data)
>>   {
>>          struct amd_pmf_dev *pmf = container_of(nb, struct amd_pmf_dev, pwr_src_notifier);
>> @@ -349,6 +353,10 @@ static void amd_pmf_init_features(struct amd_pmf_dev *dev)
>>                  dev_dbg(dev->dev, "SPS enabled and Platform Profiles registered\n");
>>          }
>>
>> +       if (pmf_manual_control) {
>> +               amd_pmf_init_manual_control(dev);
>> +               return;
>> +       }
>>          amd_pmf_init_smart_pc(dev);
>>          if (dev->smart_pc_enabled) {
>>                  dev_dbg(dev->dev, "Smart PC Solution Enabled\n");
>> @@ -485,6 +493,7 @@ static void amd_pmf_remove(struct platform_device *pdev)
>>
>>   static const struct attribute_group *amd_pmf_driver_groups[] = {
>>          &cnqf_feature_attribute_group,
>> +       &manual_attribute_group,
>>          NULL,
>>   };
>>
>> diff --git a/drivers/platform/x86/amd/pmf/manual.c b/drivers/platform/x86/amd/pmf/manual.c
>> new file mode 100644
>> index 000000000000..b33fc3cd8d61
>> --- /dev/null
>> +++ b/drivers/platform/x86/amd/pmf/manual.c
>> @@ -0,0 +1,88 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * AMD Platform Management Framework Driver
>> + *
>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Mario Limonciello <mario.limonciello@amd.com>
>> + */
>> +
>> +#include "pmf.h"
>> +
>> +#define pmf_manual_attribute(_name, _set_command, _get_command)                \
>> +static ssize_t _name##_store(struct device *d,                         \
>> +                            struct device_attribute *attr,             \
>> +                            const char *buf, size_t count)             \
>> +{                                                                      \
>> +       struct amd_pmf_dev *dev = dev_get_drvdata(d);                   \
>> +       uint val;                                                       \
>> +                                                                       \
>> +       if (dev->current_profile != PLATFORM_PROFILE_CUSTOM) {          \
>> +               dev_warn_once(dev->dev,                                 \
>> +                             "Manual control is disabled, please set " \
>> +                             "platform profile to custom.\n");         \
>> +               return -EINVAL;                                         \
>> +       }                                                               \
>> +                                                                       \
>> +       if (kstrtouint(buf, 10, &val) < 0)                              \
>> +               return -EINVAL;                                         \
>> +                                                                       \
>> +       amd_pmf_send_cmd(dev, _set_command, false, val, NULL);          \
>> +                                                                       \
>> +       return count;                                                   \
>> +}                                                                      \
>> +static ssize_t _name##_show(struct device *d,                          \
>> +                          struct device_attribute *attr,               \
>> +                          char *buf)                                   \
>> +{                                                                      \
>> +       struct amd_pmf_dev *dev = dev_get_drvdata(d);                   \
>> +       uint val;                                                       \
>> +                                                                       \
>> +       amd_pmf_send_cmd(dev, _get_command, true, ARG_NONE, &val);      \
>> +                                                                       \
>> +       return sysfs_emit(buf, "%u\n", val);                            \
>> +}
>> +
>> +pmf_manual_attribute(spl, SET_SPL, GET_SPL);
>> +static DEVICE_ATTR_RW(spl);
>> +pmf_manual_attribute(fppt, SET_FPPT, GET_FPPT);
>> +static DEVICE_ATTR_RW(fppt);
>> +pmf_manual_attribute(sppt, SET_SPPT, GET_SPPT);
>> +static DEVICE_ATTR_RW(sppt);
>> +pmf_manual_attribute(sppt_apu_only, SET_SPPT_APU_ONLY, GET_SPPT_APU_ONLY);
>> +static DEVICE_ATTR_RW(sppt_apu_only);
>> +pmf_manual_attribute(stt_min, SET_STT_MIN_LIMIT, GET_STT_MIN_LIMIT);
>> +static DEVICE_ATTR_RW(stt_min);
>> +pmf_manual_attribute(stt_limit_apu, SET_STT_LIMIT_APU, GET_STT_LIMIT_APU);
>> +static DEVICE_ATTR_RW(stt_limit_apu);
>> +pmf_manual_attribute(stt_skin_temp, SET_STT_LIMIT_HS2, GET_STT_LIMIT_HS2);
>> +static DEVICE_ATTR_RW(stt_skin_temp);
>> +
>> +static umode_t manual_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
>> +{
>> +       return pmf_manual_control ? 0660 : 0;
>> +}
>> +
>> +static struct attribute *manual_attrs[] = {
>> +       &dev_attr_spl.attr,
>> +       &dev_attr_fppt.attr,
>> +       &dev_attr_sppt.attr,
>> +       &dev_attr_sppt_apu_only.attr,
>> +       &dev_attr_stt_min.attr,
>> +       &dev_attr_stt_limit_apu.attr,
>> +       &dev_attr_stt_skin_temp.attr,
>> +       NULL,
>> +};
>> +
>> +const struct attribute_group manual_attribute_group = {
>> +       .attrs = manual_attrs,
>> +       .is_visible = manual_attr_is_visible,
>> +};
>> +
>> +void amd_pmf_init_manual_control(struct amd_pmf_dev *dev)
>> +{
>> +       add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
>> +       pr_crit("Manual PMF control is enabled, please disable it before "
>> +               "reporting any bugs unrelated to PMF.\n");
>> +}
>> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
>> index 8ce8816da9c1..ca3df63cf190 100644
>> --- a/drivers/platform/x86/amd/pmf/pmf.h
>> +++ b/drivers/platform/x86/amd/pmf/pmf.h
>> @@ -798,4 +798,9 @@ void amd_pmf_dump_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *
>>   /* Quirk infrastructure */
>>   void amd_pmf_quirks_init(struct amd_pmf_dev *dev);
>>
>> +/* Manual configuration */
>> +extern bool pmf_manual_control;
>> +extern const struct attribute_group manual_attribute_group;
>> +void amd_pmf_init_manual_control(struct amd_pmf_dev *dev);
>> +
>>   #endif /* PMF_H */
>> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
>> index 92f7fb22277d..6db88e523a86 100644
>> --- a/drivers/platform/x86/amd/pmf/sps.c
>> +++ b/drivers/platform/x86/amd/pmf/sps.c
>> @@ -305,6 +305,8 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
>>          case PLATFORM_PROFILE_LOW_POWER:
>>                  mode = POWER_MODE_POWER_SAVER;
>>                  break;
>> +       case PLATFORM_PROFILE_CUSTOM:
>> +               return 0;
>>          default:
>>                  dev_err(pmf->dev, "Unknown Platform Profile.\n");
>>                  return -EOPNOTSUPP;
>> @@ -412,6 +414,8 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>>          set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
>>          set_bit(PLATFORM_PROFILE_BALANCED, dev->pprof.choices);
>>          set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
>> +       if (pmf_manual_control)
>> +               set_bit(PLATFORM_PROFILE_CUSTOM, dev->pprof.choices);
>>
>>          /* Create platform_profile structure and register */
>>          err = platform_profile_register(&dev->pprof);
>> --
>> 2.43.0
>>


