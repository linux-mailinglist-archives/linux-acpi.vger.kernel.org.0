Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62DC317434
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 00:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhBJXSQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 18:18:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:24009 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234112AbhBJXQw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 18:16:52 -0500
IronPort-SDR: y8X6sx8pefDU/c07McE+yuUdbSlAyW2ZKY7G8AL2NdM3rocQI9sJxsvSwcaEP3hq7+rx6qYLmU
 P39dKocLqP4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="181393544"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="181393544"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 15:15:20 -0800
IronPort-SDR: oBi1/dF7FKvJM5Aq1ajJ0CRa0qM0MmgAhgytvZ12WxY86lshpf9xP7EIhMvCh0M9PYzL/J+YCu
 wEqCEUmlYtGg==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="396984385"
Received: from ichakrab-mobl2.amr.corp.intel.com (HELO [10.212.48.39]) ([10.212.48.39])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 15:15:18 -0800
Subject: Re: [PATCH 1/2] soundwire: intel: fix possible crash when no device
 is detected
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Marcin_=c5=9alusarz?= <marcin.slusarz@gmail.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        marcin.slusarz@intel.com, Vinod Koul <vkoul@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
References: <a3f01a5d-d7a5-8280-4091-b2486b01a782@linux.intel.com>
 <20210208120104.204761-1-marcin.slusarz@gmail.com>
 <CAJZ5v0gftDzua87J0To87=Huer2q=_z=0Bj2q++OQAYNtPe86w@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e6d3f589-fa9b-baee-8dba-6a7c09e50b83@linux.intel.com>
Date:   Wed, 10 Feb 2021 17:15:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gftDzua87J0To87=Huer2q=_z=0Bj2q++OQAYNtPe86w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2/8/21 6:37 AM, Rafael J. Wysocki wrote:
> On Mon, Feb 8, 2021 at 1:01 PM Marcin Ślusarz <marcin.slusarz@gmail.com> wrote:
>>
>> From: Marcin Ślusarz <marcin.slusarz@intel.com>
>>
>> acpi_walk_namespace can return success without executing our
>> callback which initializes info->handle.
>> If the random value in this structure is a valid address (which
>> is on the stack, so it's quite possible), then nothing bad will
>> happen, because:
>> sdw_intel_scan_controller
>>   -> acpi_bus_get_device
>>   -> acpi_get_device_data
>>   -> acpi_get_data_full
>>   -> acpi_ns_validate_handle
>> will reject this handle.
>>
>> However, if the value from the stack doesn't point to a valid
>> address, we get this:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000050
>> PGD 0 P4D 0
>> Oops: 0000 [#1] SMP NOPTI
>> CPU: 6 PID: 472 Comm: systemd-udevd Tainted: G        W         5.10.0-1-amd64 #1 Debian 5.10.4-1
>> Hardware name: HP HP Pavilion Laptop 15-cs3xxx/86E2, BIOS F.05 01/01/2020
>> RIP: 0010:acpi_ns_validate_handle+0x1a/0x23
>> Code: 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00 48 8d 57 ff 48 89 f8 48 83 fa fd 76 08 48 8b 05 0c b8 67 01 c3 <80> 7f 08 0f 74 02 31 c0 c3 0f 1f 44 00 00 48 8b 3d f6 b7 67 01 e8
>> RSP: 0000:ffffc388807c7b20 EFLAGS: 00010213
>> RAX: 0000000000000048 RBX: ffffc388807c7b70 RCX: 0000000000000000
>> RDX: 0000000000000047 RSI: 0000000000000246 RDI: 0000000000000048
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> R10: ffffffffc0f5f4d1 R11: ffffffff8f0cb268 R12: 0000000000001001
>> R13: ffffffff8e33b160 R14: 0000000000000048 R15: 0000000000000000
>> FS:  00007f24548288c0(0000) GS:ffff9f781fb80000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000050 CR3: 0000000106158004 CR4: 0000000000770ee0
>> PKRU: 55555554
>> Call Trace:
>>   acpi_get_data_full+0x4d/0x92
>>   acpi_bus_get_device+0x1f/0x40
>>   sdw_intel_acpi_scan+0x59/0x230 [soundwire_intel]
>>   ? strstr+0x22/0x60
>>   ? dmi_matches+0x76/0xe0
>>   snd_intel_dsp_driver_probe.cold+0xaf/0x163 [snd_intel_dspcfg]
>>   azx_probe+0x7a/0x970 [snd_hda_intel]
>>   local_pci_probe+0x42/0x80
>>   ? _cond_resched+0x16/0x40
>>   pci_device_probe+0xfd/0x1b0
>>   really_probe+0x205/0x460
>>   driver_probe_device+0xe1/0x150
>>   device_driver_attach+0xa1/0xb0
>>   __driver_attach+0x8a/0x150
>>   ? device_driver_attach+0xb0/0xb0
>>   ? device_driver_attach+0xb0/0xb0
>>   bus_for_each_dev+0x78/0xc0
>>   bus_add_driver+0x12b/0x1e0
>>   driver_register+0x8b/0xe0
>>   ? 0xffffffffc0f65000
>>   do_one_initcall+0x44/0x1d0
>>   ? do_init_module+0x23/0x250
>>   ? kmem_cache_alloc_trace+0xf5/0x200
>>   do_init_module+0x5c/0x250
>>   __do_sys_finit_module+0xb1/0x110
>>   do_syscall_64+0x33/0x80
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> CC: stable@vger.kernel.org
>> Signed-off-by: Marcin Ślusarz <marcin.slusarz@intel.com>
>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Adding Vinod, Takashi, Mark and Jaroslav in CC: to make sure this patch 
does not fall between the cracks.

This issue may impact all HDaudio platforms and this patch needs to 
reach Linus' tree and 5.10-stable. Thanks!

> 
>> ---
>>   drivers/soundwire/intel_init.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
>> index cabdadb09a1b..bc8520eb385e 100644
>> --- a/drivers/soundwire/intel_init.c
>> +++ b/drivers/soundwire/intel_init.c
>> @@ -405,11 +405,12 @@ int sdw_intel_acpi_scan(acpi_handle *parent_handle,
>>   {
>>          acpi_status status;
>>
>> +       info->handle = NULL;
>>          status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
>>                                       parent_handle, 1,
>>                                       sdw_intel_acpi_cb,
>>                                       NULL, info, NULL);
>> -       if (ACPI_FAILURE(status))
>> +       if (ACPI_FAILURE(status) || info->handle == NULL)
>>                  return -ENODEV;
>>
>>          return sdw_intel_scan_controller(info);
>> --
>> 2.25.1
>>
