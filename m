Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF854D23A5
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Mar 2022 22:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350634AbiCHVxF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Mar 2022 16:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345801AbiCHVwx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2022 16:52:53 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F97656774
        for <linux-acpi@vger.kernel.org>; Tue,  8 Mar 2022 13:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646776316; x=1678312316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCU3m5JdeJd3EuRuLL4QK7bIkUbcoH6IAo2/eajax3I=;
  b=Yv3DJyhzsYeiHjE22wX0y3pFq2ypkPWtj1uG5ecIcyptH47IMCA87kgy
   ONZl1ePHOgCNYd1CjyW2c55z9R0eLQe4poop3CrmOGbtcP87et8MbJtmQ
   KBoUsERKenps3NPHKVqMCLRTKgXKDi1zHZYBygNi38GlWBuya58OP/bGc
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Mar 2022 13:51:56 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:51:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Mar 2022 13:51:54 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 8 Mar 2022
 13:51:52 -0800
Date:   Tue, 8 Mar 2022 16:51:50 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>
Subject: Re: [PATCH v4 2/3] ACPI: bus: Allow negotiating OSC capabilities
Message-ID: <YifP9vKoGzyZyRJB@qian>
References: <20220301124908.1931221-1-mario.limonciello@amd.com>
 <20220301124908.1931221-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220301124908.1931221-2-mario.limonciello@amd.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 01, 2022 at 06:49:07AM -0600, Mario Limonciello wrote:
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 07f604832fd6..302619ad9d31 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -184,6 +184,18 @@ static void acpi_print_osc_error(acpi_handle handle,
>  	pr_debug("\n");
>  }
>  
> +/**
> + * acpi_run_osc - Evaluate the _OSC method for a given ACPI handle
> + * @handle: ACPI handle containing _OSC to evaluate
> + * @context: A structure specifying UUID, revision, and buffer for data
> + *
> + * Used for negotiating with firmware the capabilities that will be used
> + * by the OSPM.  Although the return type is acpi_status, the ACPI_SUCCESS
> + * macro can not be used to determine whether to free the buffer of
> + * returned data.
> + *
> + * The buffer must be freed when this function returns AE_OK or AE_SUPPORT.
> + */
>  acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
>  {
>  	acpi_status status;
> @@ -243,16 +255,19 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
>  			acpi_print_osc_error(handle, context,
>  				"_OSC invalid revision");
>  		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
> +			acpi_print_osc_error(handle, context, "_OSC capabilities masked");
>  			if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD]
> -			    & OSC_QUERY_ENABLE)
> -				goto out_success;
> -			status = AE_SUPPORT;
> -			goto out_kfree;
> +			    & OSC_QUERY_ENABLE) {
> +				status = AE_SUPPORT;
> +				goto out_masked;
> +			}
>  		}
>  		status = AE_ERROR;
>  		goto out_kfree;
>  	}
> -out_success:
> +
> +	status =  AE_OK;
> +out_masked:
>  	context->ret.length = out_obj->buffer.length;
>  	context->ret.pointer = kmemdup(out_obj->buffer.pointer,
>  				       context->ret.length, GFP_KERNEL);
> @@ -260,7 +275,6 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
>  		status =  AE_NO_MEMORY;
>  		goto out_kfree;
>  	}
> -	status =  AE_OK;
>  
>  out_kfree:
>  	kfree(output.pointer);

Do we forget to free "context.ret.pointer" in acpi_pci_run_osc() as well
when acpi_run_osc() starts to return AE_SUPPORT? I saw memory leaks on the
latest linux-next which include this series.

# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff07ff968c6e80 (size 128):
  comm "swapper/0", pid 1, jiffies 4294894996 (age 1785.652s)
  hex dump (first 32 bytes):
    11 00 00 00 1f 01 00 00 18 00 00 00 6b 6b 6b 6b  ............kkkk
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  backtrace:
    [<ffffad5bd9d79adc>] __kmalloc_track_caller
    [<ffffad5bd9c439f4>] kmemdup
    [<ffffad5bda97c710>] acpi_run_osc
    acpi_run_osc at drivers/acpi/bus.c:272
    [<ffffad5bdc52f8a8>] acpi_pci_run_osc
    acpi_pci_run_osc at drivers/acpi/pci_root.c:184
    [<ffffad5bdc52fe30>] negotiate_os_control.constprop.0
    acpi_pci_query_osc at drivers/acpi/pci_root.c:205
    (inlined by) acpi_pci_osc_control_set at drivers/acpi/pci_root.c:353
    (inlined by) negotiate_os_control at drivers/acpi/pci_root.c:482
    [<ffffad5bda995748>] acpi_pci_root_add
    [<ffffad5bda982558>] acpi_bus_attach
    [<ffffad5bda9823c8>] acpi_bus_attach
    [<ffffad5bda9823c8>] acpi_bus_attach
    [<ffffad5bda98808c>] acpi_bus_scan
    [<ffffad5bdd9624a0>] acpi_scan_init
    [<ffffad5bdd961e74>] acpi_init
    [<ffffad5bd9595438>] do_one_initcall
    [<ffffad5bdd90201c>] kernel_init_freeable
    [<ffffad5bdc5684e0>] kernel_init
    [<ffffad5bd959841c>] ret_from_fork
