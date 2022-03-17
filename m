Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA51E4DCE39
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 19:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiCQS4a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 14:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237767AbiCQS41 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 14:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBAF0166E22
        for <linux-acpi@vger.kernel.org>; Thu, 17 Mar 2022 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647543289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6Z+ZrU/WzFIpn8/Q9lZmmJP5+YBGeBhqfHKRt47t4I=;
        b=GiAcPTxozJbCbzJ8rwNarQMsN7r+jVx0QsTLzigQXtrDjyO96Cd3aq8Q2RrgQll9GCDmyR
        X8+6s3IgGTKMocjAr9snso0xL+OcucQF+XIBzdUWIX/UfUfoHCUj2l2WTRp4wya2TImbmp
        K3jO4W7Uf1jRUkaDgLR+gYgHLBM3xTs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-BR6MDYHdNIKvhIuKueGExA-1; Thu, 17 Mar 2022 14:54:48 -0400
X-MC-Unique: BR6MDYHdNIKvhIuKueGExA-1
Received: by mail-ed1-f69.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so3625714edw.7
        for <linux-acpi@vger.kernel.org>; Thu, 17 Mar 2022 11:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w6Z+ZrU/WzFIpn8/Q9lZmmJP5+YBGeBhqfHKRt47t4I=;
        b=DECmxNt9E555+QmJSlyw0pDB3ztiMV4ECB4xOOCij4XHmND1wmSkRYgLcBbyi7hAry
         RROUbBtyUpm0c9hoi4ZkTzTXvRke9PIPXrjQkLCYvAn/ZnDlTj80rrkBiLXgaVlbcWM6
         n5QaAyT8ES9fC7ghR0Xg0apnQGF8I2Hlri7zotP7ZNj3xKgOuwr2WeILkojPuiAPjqz+
         ZI53YBpx2XLms6Pwy1WGXSA/CCrG2lkzz81cVefaw0u+td9d7xo9hkYBFHwBiW3n5LpV
         9hgIsOudHB4RIu21X+qDigSxwLk25wYsNSKhJGlYFq+Gl6SFK3wQNqNbnTMqmFWVIS9j
         xU2g==
X-Gm-Message-State: AOAM532RKAHZo3QGwBK7VMBAONlUHn6GMU/ZjgzsjawxStBH19iHGK4r
        ihiOJuFEouTKRUgN0g6x/YOZwAuXzyWFbEg3+Dj0ntYJYDEpCyEClZoYWtJaJzewQDl2SH1M/z0
        OPn1OJYfSYZfrTmW2WGQGHg==
X-Received: by 2002:a17:907:7f94:b0:6da:64ec:fabc with SMTP id qk20-20020a1709077f9400b006da64ecfabcmr5968309ejc.717.1647543287173;
        Thu, 17 Mar 2022 11:54:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpb6lkIFh29vSSkzi6s4bSalDVrvocJyedoKO4X9MxQfG9e9VQbbi72h7lsAz8HHDWWP72Tw==
X-Received: by 2002:a17:907:7f94:b0:6da:64ec:fabc with SMTP id qk20-20020a1709077f9400b006da64ecfabcmr5968292ejc.717.1647543286901;
        Thu, 17 Mar 2022 11:54:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906b10500b006ce6fa4f510sm2729082ejy.165.2022.03.17.11.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 11:54:46 -0700 (PDT)
Message-ID: <d86160c2-2478-5d8e-10c4-f2691dc87012@redhat.com>
Date:   Thu, 17 Mar 2022 19:54:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 4/4] platform/x86: amd-pmc: Drop CPU QoS workaround
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Goswami Sanket <Sanket.Goswami@amd.com>
References: <20220317141445.6498-1-mario.limonciello@amd.com>
 <20220317141445.6498-4-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220317141445.6498-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/17/22 15:14, Mario Limonciello wrote:
> A workaround was previously introduced as part of commit 646f429ec2de
> ("platform/x86: amd-pmc: Set QOS during suspend on CZN w/ timer wakeup")
> to prevent CPUs from going into the deepest state during the execution
> of the `noirq` stage of `amd_pmc`.  As `amd_pmc` has been pushed to the
> last step for suspend on AMD platforms, this workaround is no longer
> necessary.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> changes from v4->v5:
>  * rebase on earlier patches
> changes from v3->v4:
>  * rebase on earlier patches
> changes from v2->v3:
>  * No changes
> changes from v1->v2:
>  * No changes
> 
>  drivers/platform/x86/amd-pmc.c | 32 +++-----------------------------
>  1 file changed, 3 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index f36cf125b284..7317993cd91b 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -21,7 +21,6 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> -#include <linux/pm_qos.h>
>  #include <linux/rtc.h>
>  #include <linux/suspend.h>
>  #include <linux/seq_file.h>
> @@ -96,9 +95,6 @@
>  #define PMC_MSG_DELAY_MIN_US		50
>  #define RESPONSE_REGISTER_LOOP_MAX	20000
>  
> -/* QoS request for letting CPUs in idle states, but not the deepest */
> -#define AMD_PMC_MAX_IDLE_STATE_LATENCY	3
> -
>  #define SOC_SUBSYSTEM_IP_MAX	12
>  #define DELAY_MIN_US		2000
>  #define DELAY_MAX_US		3000
> @@ -153,7 +149,6 @@ struct amd_pmc_dev {
>  	struct device *dev;
>  	struct pci_dev *rdev;
>  	struct mutex lock; /* generic mutex lock */
> -	struct pm_qos_request amd_pmc_pm_qos_req;
>  #if IS_ENABLED(CONFIG_DEBUG_FS)
>  	struct dentry *dbgfs_dir;
>  #endif /* CONFIG_DEBUG_FS */
> @@ -628,14 +623,6 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>  	rc = rtc_alarm_irq_enable(rtc_device, 0);
>  	dev_dbg(pdev->dev, "wakeup timer programmed for %lld seconds\n", duration);
>  
> -	/*
> -	 * Prevent CPUs from getting into deep idle states while sending OS_HINT
> -	 * which is otherwise generally safe to send when at least one of the CPUs
> -	 * is not in deep idle states.
> -	 */
> -	cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req, AMD_PMC_MAX_IDLE_STATE_LATENCY);
> -	wake_up_all_idle_cpus();
> -
>  	return rc;
>  }
>  
> @@ -655,7 +642,7 @@ static void amd_pmc_s2idle_prepare(void)
>  		rc = amd_pmc_verify_czn_rtc(pdev, &arg);
>  		if (rc) {
>  			dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
> -			goto fail;
> +			return;
>  		}
>  	}
>  
> @@ -665,20 +652,13 @@ static void amd_pmc_s2idle_prepare(void)
>  	rc = amd_pmc_send_cmd(pdev, arg, NULL, msg, 0);
>  	if (rc) {
>  		dev_err(pdev->dev, "suspend failed: %d\n", rc);
> -		goto fail;
> +		return;
>  	}
>  
>  	if (enable_stb)
>  		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
> -	if (rc) {
> +	if (rc)
>  		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
> -		goto fail;
> -	}

Ok, this entire series has been merged here now:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

now lets hope none of the various build tests become unhappy because of this.

Mario, one request, the:

	if (rc)
		dev_err(pdev->dev, "error writing to STB: %d\n", rc);

above looks weird, can you do a follow-up patch moving that to
inside/under the "if (enable_stb)" check ?

Currently it also rechecks the amd_pmc_verify_czn_rtc() when
enable_stb is false, which is weird.

Regards,

Hans





> -	return;
> -fail:
> -	if (pdev->cpu_id == AMD_CPU_ID_CZN)
> -		cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req,
> -						PM_QOS_DEFAULT_VALUE);
>  }
>  
>  static void amd_pmc_s2idle_restore(void)



> @@ -704,11 +684,6 @@ static void amd_pmc_s2idle_restore(void)
>  	if (rc)
>  		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
>  
> -	/* Restore the QoS request back to defaults if it was set */
> -	if (pdev->cpu_id == AMD_CPU_ID_CZN)
> -		cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req,
> -						PM_QOS_DEFAULT_VALUE);
> -
>  	/* Notify on failed entry */
>  	amd_pmc_validate_deepest(pdev);
>  }
> @@ -887,7 +862,6 @@ static int amd_pmc_probe(struct platform_device *pdev)
>  		dev_warn(dev->dev, "failed to register LPS0 sleep handler, expect increased power consumption\n");
>  
>  	amd_pmc_dbgfs_register(dev);
> -	cpu_latency_qos_add_request(&dev->amd_pmc_pm_qos_req, PM_QOS_DEFAULT_VALUE);
>  	return 0;
>  
>  err_pci_dev_put:

