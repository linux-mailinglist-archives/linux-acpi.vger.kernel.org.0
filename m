Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D40377C5F
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 08:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhEJGin convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 10 May 2021 02:38:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:46553 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhEJGim (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 02:38:42 -0400
IronPort-SDR: f61N0gRtyAsotoQWLXHhRo33GXcV+vjq3y9RtD1lBY6JHmO8p/o9F6dswkgfl6yZIOB5GEdMct
 O7qwy9DKYodQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="199174553"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="199174553"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2021 23:37:38 -0700
IronPort-SDR: NxCwymvFZvh6DxYRcDjbhoByrIsM6+fQXxNhK94nJfHX0IdPCsw4ts1ndVbN+VHa4/N4LKfGkq
 bl0o/RCNExCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="467974727"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 09 May 2021 23:37:38 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 9 May 2021 23:37:37 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 10 May 2021 14:37:35 +0800
Received: from shsmsx603.ccr.corp.intel.com ([10.109.6.143]) by
 SHSMSX603.ccr.corp.intel.com ([10.109.6.143]) with mapi id 15.01.2106.013;
 Mon, 10 May 2021 14:37:35 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     Shujun Wang <wsj20369@163.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Revert "ACPI: power: Turn off unused power resources
 unconditionally"
Thread-Topic: [PATCH] Revert "ACPI: power: Turn off unused power resources
 unconditionally"
Thread-Index: AQHXPb5+qq82JOqVIEyyCWhpAV7v56rcT9ZA
Date:   Mon, 10 May 2021 06:37:35 +0000
Message-ID: <0e480ceabe4d42d79bf49a1989c0f95f@intel.com>
References: <20210430124224.6383-1-wsj20369@163.com>
In-Reply-To: <20210430124224.6383-1-wsj20369@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Shujun,

I'm experiencing similar problem, and it should be a BIOS problem, which can be fixed by a customized DSDT.
Can you please attach the full acpidump output on this machine? I just want to make sure if it is the same problem.

Thanks,
rui

> -----Original Message-----
> From: Shujun Wang <wsj20369@163.com>
> Sent: Friday, April 30, 2021 8:42 PM
> To: rjw@rjwysocki.net; lenb@kernel.org; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Shujun Wang <wsj20369@163.com>
> Subject: [PATCH] Revert "ACPI: power: Turn off unused power resources
> unconditionally"
> 
> This reverts commit 7e4fdeafa61f2b653fcf9678f09935e55756aed2.
> It may cause some NVMe device probes to fail, and the system may get stuck
> when using an NVMe device as the root filesystem.
> 
> In the function nvme_pci_enable(struct nvme_dev *dev), as shown below,
> readl(NVME_REG_CSTS) always returns -1 with the commit, which results in
> the probe failed.
> 
>   if (readl(dev->bar + NVME_REG_CSTS) == -1) {
> 	result = -ENODEV;
> 	goto disable;
>   }
> 
> dmesg:
>   [    1.106280] nvme 0000:04:00.0: platform quirk: setting simple suspend
>   [    1.109111] nvme nvme0: pci function 0000:04:00.0
>   [    1.113066] nvme 0000:04:00.0: enabling device (0000 -> 0002)
>   [    1.121040] nvme nvme0: Removing after probe failure status: -19
> 
> lspci:
>   Non-Volatile memory controller: KIOXIA Corporation Device 0001
> 
> device uevent:
>   DRIVER=nvme
>   PCI_CLASS=10802
>   PCI_ID=1E0F:0001
>   PCI_SUBSYS_ID=1E0F:0001
>   PCI_SLOT_NAME=0000:04:00.0
>   MODALIAS=pci:v00001E0Fd00000001sv00001E0Fsd00000001bc01sc08i02
> 
> This patch was tested in Lenovo Thinkpad X1.
> 
> Signed-off-by: Shujun Wang <wsj20369@163.com>
> ---
>  drivers/acpi/power.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c index
> 56102eaaa2da..8bf10abeb2e0 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -1004,9 +1004,18 @@ void
> acpi_turn_off_unused_power_resources(void)
>  	mutex_lock(&power_resource_list_lock);
> 
>  	list_for_each_entry_reverse(resource, &acpi_power_resource_list,
> list_node) {
> +		int result, state;
> +
>  		mutex_lock(&resource->resource_lock);
> 
> -		if (!resource->ref_count) {
> +		result = acpi_power_get_state(resource->device.handle,
> &state);
> +		if (result) {
> +			mutex_unlock(&resource->resource_lock);
> +			continue;
> +		}
> +
> +		if (state == ACPI_POWER_RESOURCE_STATE_ON
> +		    && !resource->ref_count) {
>  			dev_info(&resource->device.dev, "Turning OFF\n");
>  			__acpi_power_off(resource);
>  		}
> --
> 2.25.1

