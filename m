Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209CB428230
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Oct 2021 17:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhJJPMv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Oct 2021 11:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232778AbhJJPMu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 10 Oct 2021 11:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633878651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymYBEBSUvf6CaVJZTg55f7eZ0XT38KYWfIPvyX/VujI=;
        b=D/ogrlM/OxA6lV3KzvWHGmNlKTkEyB5yjC9uj/NtJbYc3ATIByvivJ5wg2bQ8Fu3z+V+mJ
        +KwUz2NaMkntB/DcwHtPWvipV3L6truq1f0qqfAbQ8QI54z5UMDMl97dy9BxvpTBBnCg2V
        lghuKB5YzZIRtk4jsdeD+EtCjmGYqG0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-KvNGO5t0O7ibvkLh5T7BiA-1; Sun, 10 Oct 2021 11:10:50 -0400
X-MC-Unique: KvNGO5t0O7ibvkLh5T7BiA-1
Received: by mail-ed1-f69.google.com with SMTP id e14-20020a056402088e00b003db6ebb9526so3933726edy.22
        for <linux-acpi@vger.kernel.org>; Sun, 10 Oct 2021 08:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ymYBEBSUvf6CaVJZTg55f7eZ0XT38KYWfIPvyX/VujI=;
        b=y4yZs+fxY7negim/gwt2J9kAEwPavJc4TErHGf1zKU1LDz3VT6NKI54xhTxcu/sLxH
         NacUH4JNcd768aldwgZXjR3t9CAejhKMn7PVzw1mXVmKys64d1iGgGAqb/xhkdzHIKCa
         C9qsUyTIIt/iRxZuJzKeUrWjKFcrvYHWdTxsOkbK4t+gS1pCgP4GYwjtqXQheYXc/dpa
         hWREvIEXoatIEi99TbuQTAmHwlNTtNoVAHMyrtISeMSEyuDeNTKCm7MdmdGHOTxibonv
         EPrDdCDuRPch2sFE5C1qxTlb6D+f8bwXLj8cB5LTqLvNE15xmPWNz46N2+rmSmm9LLzl
         VllA==
X-Gm-Message-State: AOAM533W+5B+1xTIKaGRNdmmuoOKqFSVe45Cxnt6u+JRTBLjRoGNABQV
        92DzOKU5vYHL0QqakhjDCaFLXH9uq1JgONgoM5wqCttm1I5JH21TNBD4h15lvCjSI4ICNq78D08
        aGYO1clTXUUS2XFf/ZSgmwQ==
X-Received: by 2002:a05:6402:268c:: with SMTP id w12mr32262451edd.376.1633878648647;
        Sun, 10 Oct 2021 08:10:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLPx4rw5dSOqmTSWeFvO+pX78uTWdkgxG68sKgpA1md+rOQ4QAYdlxxEJVEnKXjnU/oTQ3mQ==
X-Received: by 2002:a05:6402:268c:: with SMTP id w12mr32262422edd.376.1633878648447;
        Sun, 10 Oct 2021 08:10:48 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h11sm2171214eji.96.2021.10.10.08.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 08:10:48 -0700 (PDT)
Subject: Re: [PATCH v2 02/13] ACPI: honor dependencies for devices with a _DEP
 pointing to an INT3472 device
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20211009160548.306550-1-hdegoede@redhat.com>
 <20211009160548.306550-3-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d90f8514-a779-06ad-5e8d-5c42a5771b15@redhat.com>
Date:   Sun, 10 Oct 2021 17:10:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211009160548.306550-3-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/9/21 6:05 PM, Hans de Goede wrote:
> The clk and regulator frameworks expect clk/regulator consumer-devices
> to have info about the consumed clks/regulators described in the device's
> fw_node.
> 
> To work around cases where this info is not present in the firmware tables,
> which is often the case on x86/ACPI devices, both frameworks allow the
> provider-driver to attach info about consumers to the clks/regulators
> when registering these.
> 
> This causes problems with the probe ordering wrt drivers for consumers
> of these clks/regulators. Since the lookups are only registered when the
> provider-driver binds, trying to get these clks/regulators before then
> results in a -ENOENT error for clks and a dummy regulator for regulators.
> 
> One case where we hit this issue is camera sensors such as e.g. the OV8865
> sensor found on the Microsoft Surface Go. The sensor uses clks, regulators
> and GPIOs provided by a TPS68470 PMIC which is described in an INT3472
> ACPI device. There is special platform code handling this and setting
> platform_data with the necessary consumer info on the MFD cells
> instantiated for the PMIC under: drivers/platform/x86/intel/int3472.
> 
> For this to work properly the ov8865 driver must not bind to the i2c-client
> for the OV8865 sensor until after the TPS68470 PMIC gpio, regulator and
> clk MFD cells have all been fully setup.
> 
> The OV8865 on the Microsoft Surface Go is just one example, all X86
> devices using the Intel IPU3 camera block found on recent Intel SoCs
> have similar issues where there is an INT3472 HID ACPI-device which
> describes the clks and regulators and the driver for this INT3472 device
> must be fully initialized before the sensor driver (any sensor driver)
> binds for things to work properly.
> 
> On these devices the ACPI nodes describing the sensors all have a _DEP
> dependency on the matching INT3472 ACPI device (there is one per sensor).
> 
> This allows solving the probe-ordering problem by making ACPI-devices
> honor the _DEP dependencies (like we already do for batteries) when they
> have a dependency on an INT3472 device.
> 
> Note the matching is done on there being a _DEP on an INT3472 device,
> rather then matching on the HID of the sensor device itself to avoid
> having to maintain an ever growing list of HIDs of sensors which need
> the honor_dep behavior.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

In the end I was not entirely happy with the approach in patch 1 + 2
(this patch) myself, reporting 0 for the status of some devices until
the _DEP-s are met has some troublesome implications for code which
behavior depends on acpi_dev_is_present() calls (or equivalent code).

Which led to the: "[PATCH v2 13/13] media: ipu3-cio2: Add module
soft-deps for the INT3472 drivers" adding unnecessary soft
module-dependencies to the ipu3-cio2 code to make sure that the
status was not reported as 0 because of unmet deps when that code
runs.

Besides these soft-deps being non-sense / undesirable. This also
is a bit racy since the status only gets updated to reflect the
unmet_deps==0 once the acpi_scan_clear_dep() workqueue work
has run and there is no guarantee the work has fully run
once the modprobe-s of the INT3472 are done (it should run
soon afterwards, but there is a race there).

So I'm working on a rewrite of patch 1 + 2 now which replaces
the approach where we "lie" about the status with deferring the
enumeration step (1) until all the _DEP-s are met (for select
devices).

Expect a v3 with this new approach soon...

Regards,

Hans



1) The step where a platform_device or e.g. i2c-client is
instantiated as physical_device_node for the ACPI-device




> ---
>  drivers/acpi/scan.c     | 16 ++++++++++++++--
>  include/acpi/acpi_bus.h |  1 +
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 4e0a946b35ed..976724540197 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -796,6 +796,12 @@ static const char * const acpi_ignore_dep_ids[] = {
>  	NULL
>  };
>  
> +/* List of HIDs for which we honor deps of matching ACPI devs, when checking _DEP lists. */
> +static const char * const acpi_honor_dep_ids[] = {
> +	"INT3472", /* Camera sensor PMIC / clk and regulator info */
> +	NULL
> +};
> +
>  static struct acpi_device *acpi_bus_get_parent(acpi_handle handle)
>  {
>  	struct acpi_device *device = NULL;
> @@ -1761,8 +1767,12 @@ static void acpi_scan_dep_init(struct acpi_device *adev)
>  		adev->honor_deps = true;
>  
>  	list_for_each_entry(dep, &acpi_dep_list, node) {
> -		if (dep->consumer == adev->handle)
> +		if (dep->consumer == adev->handle) {
> +			if (dep->honor_dep)
> +				adev->honor_deps = true;
> +
>  			adev->dep_unmet++;
> +		}
>  	}
>  }
>  
> @@ -1966,7 +1976,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
>  	for (count = 0, i = 0; i < dep_devices.count; i++) {
>  		struct acpi_device_info *info;
>  		struct acpi_dep_data *dep;
> -		bool skip;
> +		bool skip, honor_dep;
>  
>  		status = acpi_get_object_info(dep_devices.handles[i], &info);
>  		if (ACPI_FAILURE(status)) {
> @@ -1975,6 +1985,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
>  		}
>  
>  		skip = acpi_info_matches_ids(info, acpi_ignore_dep_ids);
> +		honor_dep = acpi_info_matches_ids(info, acpi_honor_dep_ids);
>  		kfree(info);
>  
>  		if (skip)
> @@ -1988,6 +1999,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
>  
>  		dep->supplier = dep_devices.handles[i];
>  		dep->consumer = handle;
> +		dep->honor_dep = honor_dep;
>  
>  		mutex_lock(&acpi_dep_list_lock);
>  		list_add_tail(&dep->node , &acpi_dep_list);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 0ba344a5f4f8..b6fb050e77bb 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -284,6 +284,7 @@ struct acpi_dep_data {
>  	struct list_head node;
>  	acpi_handle supplier;
>  	acpi_handle consumer;
> +	bool honor_dep;
>  };
>  
>  /* Performance Management */
> 

