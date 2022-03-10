Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE94D4F6E
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 17:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiCJQhb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 11:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCJQhb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 11:37:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE0C194152;
        Thu, 10 Mar 2022 08:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646930190; x=1678466190;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yXrVj4ueVsgorKrp3nCTaEB/0IPGmBsCFjn44DQd2es=;
  b=iiiFuzXEMzGjG2HYrlAePUhy/5uhZaUNYqyRHsw/sJPg8LCi2V/7eOAZ
   aZbXmmGyUTtmxuFA1ZBGn9d9/I/HnYKIiM7EcRih26ssMmfabnklnL593
   uZNy0VYmCbmoWZsG24ekElmJnBDy1zcxAteGNvg1Qn10Q10Ox3gLZdnAC
   QOy6o5uUE0zhklZOzdd0+t6G5T/lpfgc5sAIEFjaXHWr8QUjZVZV/nLyO
   vb+50GyOQzHYBJ7p/cXDmhr6kxAM2XE5J3n95yRl2VXf8JmgRnIZRQufW
   VcrT3L1hLns6B3Y9nEh/w8eCgNWn9peIFOnBVGtPNStOjmUaFa5LakP4R
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="318519729"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="318519729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 08:35:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="644503239"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2022 08:35:27 -0800
Received: from ngpereir-MOBL.amr.corp.intel.com (unknown [10.212.217.28])
        by linux.intel.com (Postfix) with ESMTP id 1E48058093E;
        Thu, 10 Mar 2022 08:35:27 -0800 (PST)
Message-ID: <6b33269731e04c25f8766261db75dcb5e5bb60f2.camel@linux.intel.com>
Subject: Re: [PATCH 3/4] platform/x86: amd-pmc: Move to later in the suspend
 process
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, linux-acpi@vger.kernel.org
Date:   Thu, 10 Mar 2022 08:35:26 -0800
In-Reply-To: <20220310151705.577442-3-mario.limonciello@amd.com>
References: <20220310151705.577442-1-mario.limonciello@amd.com>
         <20220310151705.577442-3-mario.limonciello@amd.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2022-03-10 at 09:17 -0600, Mario Limonciello wrote:
> The `OS_HINT` message is supposed to indicate that everything else
> that is supposed to go into the deepest state has done so.
> 
> This assumption is invalid as:
> 1) The CPUs will still go in and out of the deepest state
> 2) Other devices may still run their `noirq` suspend routines
> 3) The LPS0 ACPI device will still run

Yep. We had looked at adding a notifier to address this.

David

> 
> To more closely mirror how this works on other operating systems,
> move the `amd-pmc` suspend to the very last thing before the s2idle
> loop via an lps0 callback.
> 
> Fixes: 8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-to-idle 
> path")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd-pmc.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 971aaabaa9c8..c13fd93f2662 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -639,9 +639,9 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev
> *pdev, u32 *arg)
>  	return rc;
>  }
>  
> -static int __maybe_unused amd_pmc_suspend(struct device *dev)
> +static int amd_pmc_suspend(void *context, bool constraints_met)
>  {
> -	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
> +	struct amd_pmc_dev *pdev = dev_get_drvdata((struct device *)context);
>  	int rc;
>  	u8 msg;
>  	u32 arg = 1;
> @@ -658,7 +658,7 @@ static int __maybe_unused amd_pmc_suspend(struct device
> *dev)
>  	}
>  
>  	/* Dump the IdleMask before we send hint to SMU */
> -	amd_pmc_idlemask_read(pdev, dev, NULL);
> +	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
>  	msg = amd_pmc_get_os_hint(pdev);
>  	rc = amd_pmc_send_cmd(pdev, arg, NULL, msg, 0);
>  	if (rc) {
> @@ -681,28 +681,28 @@ static int __maybe_unused amd_pmc_suspend(struct device
> *dev)
>  	return rc;
>  }
>  
> -static int __maybe_unused amd_pmc_resume(struct device *dev)
> +static void amd_pmc_resume(void *context)
>  {
> -	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
> +	struct amd_pmc_dev *pdev = dev_get_drvdata((struct device *)context);
>  	int rc;
>  	u8 msg;
>  
>  	msg = amd_pmc_get_os_hint(pdev);
>  	rc = amd_pmc_send_cmd(pdev, 0, NULL, msg, 0);
>  	if (rc)
> -		dev_err(pdev->dev, "resume failed\n");
> +		dev_err(pdev->dev, "resume failed: %d\n", rc);
>  
>  	/* Let SMU know that we are looking for stats */
>  	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
>  
>  	/* Dump the IdleMask to see the blockers */
> -	amd_pmc_idlemask_read(pdev, dev, NULL);
> +	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
>  
>  	/* Write data incremented by 1 to distinguish in stb_read */
>  	if (enable_stb)
>  		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF + 1);
>  	if (rc)
> -		dev_err(pdev->dev, "error writing to STB\n");
> +		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
>  
>  	/* Restore the QoS request back to defaults if it was set */
>  	if (pdev->cpu_id == AMD_CPU_ID_CZN)
> @@ -711,15 +711,8 @@ static int __maybe_unused amd_pmc_resume(struct device
> *dev)
>  
>  	/* Notify on failed entry */
>  	amd_pmc_validate_deepest(pdev);
> -
> -	return rc;
>  }
>  
> -static const struct dev_pm_ops amd_pmc_pm_ops = {
> -	.suspend_noirq = amd_pmc_suspend,
> -	.resume_noirq = amd_pmc_resume,
> -};
> -
>  static const struct pci_device_id pmc_pci_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_YC) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_CZN) },
> @@ -884,6 +877,12 @@ static int amd_pmc_probe(struct platform_device *pdev)
>  
>  	amd_pmc_get_smu_version(dev);
>  	platform_set_drvdata(pdev, dev);
> +	err = acpi_register_lps0_callbacks(amd_pmc_suspend,
> +					   amd_pmc_resume,
> +					   &pdev->dev);
> +	if (err)
> +		goto err_pci_dev_put;
> +
>  	amd_pmc_dbgfs_register(dev);
>  	cpu_latency_qos_add_request(&dev->amd_pmc_pm_qos_req,
> PM_QOS_DEFAULT_VALUE);
>  	return 0;
> @@ -897,6 +896,9 @@ static int amd_pmc_remove(struct platform_device *pdev)
>  {
>  	struct amd_pmc_dev *dev = platform_get_drvdata(pdev);
>  
> +	acpi_unregister_lps0_callbacks(amd_pmc_suspend,
> +					amd_pmc_resume,
> +					&pdev->dev);
>  	amd_pmc_dbgfs_unregister(dev);
>  	pci_dev_put(dev->rdev);
>  	mutex_destroy(&dev->lock);
> @@ -917,7 +919,6 @@ static struct platform_driver amd_pmc_driver = {
>  	.driver = {
>  		.name = "amd_pmc",
>  		.acpi_match_table = amd_pmc_acpi_ids,
> -		.pm = &amd_pmc_pm_ops,
>  	},
>  	.probe = amd_pmc_probe,
>  	.remove = amd_pmc_remove,

