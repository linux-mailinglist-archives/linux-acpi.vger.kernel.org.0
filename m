Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259945A04DD
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 01:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiHXXyw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 19:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHXXyu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 19:54:50 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D675BE39
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661385284; x=1692921284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n8ZhrUtA1c9SLbu3PLJ3RAqq9nJ/TAUYRUuv91BkBEY=;
  b=Pf+8q61sMhPDz0DwAo0mglPVvx1JhNqLBaNRf3CJr5ML7STZ8488HdJm
   zELzGRXm3mkyyDAJNWg2Dz6vKb4gqskiSVSpL7Kj4+Ee/QuT9EufSKvN0
   ao/HPIrvpGWujytNoGlHsEo/VPro/x4R26wCgw2pvCg4iv0z0ltGQhcYo
   eAia1/9l4r/LJcyK9RVw8ScOoW6kMMgof+tUKD8G+IT4P2QGTwX7ThZvs
   jHxiqMMFMCVzBuA+gZrt+B55iG2cm73dLrvIF4QlOEA7X74cjK67h2OjH
   J+vRINYxZwoOUcF00eaInrtuM8msrcBV+LEI6ybwmYSD8luyGf51YKF4A
   g==;
X-IronPort-AV: E=Sophos;i="5.93,261,1654531200"; 
   d="scan'208";a="209581756"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 07:54:43 +0800
IronPort-SDR: vskIoh6JuSCLGaR1hNblP/ZLIBSfwTIynsfdCyFc6l0mJ0Pe2s6r2AaWJFWsdMkw4ygi+1+0ED
 bhjTYrnMPuMr7VJzHhslz2+xnb+0L1xRqXQIkC5z/efTFaGP3KpDNQa9x8a5UXIVITjfm86vCl
 wzGwZqK1QOXczD4mD9ojy7T2w2CHnXh7eImnbu5+pVvPrNMJTQtzqqrinuaEBNrlqUIv9ZGcGF
 RoCiT9TNci69JGJmOKj0tpRSj2VigsjTX32XtOvdwRNP/9BBehpXSnPzoCrUBBPDs38mQpjXD5
 C1GOFUpg0HDzId/ooSWt4Y3F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2022 16:15:23 -0700
IronPort-SDR: /jM4qiJedArFHCAmWuvbCqyIaRJqFokJpSrN6Vcf4U51HFRjRZRSufogx/OJ4D9lj17rIXQ3tW
 vRaHGUUzYbSAcvi0PCiuBUvA00ArPPXgqJmnXuQWUR2n13cSWsmMi6P6DqKOdMKrxQcVpCDfHt
 aZ1K60gmZVE2cspTr5JVMLhdnyEFU8y2KTXq/aFMRzSgJ1pcAoWHSC7LZIPTjsGpLx2JveLLc7
 17DWL1aKMBHlGVLsAbdsiedxnMwBugOSYZgAjg+95+t50ou4/iG1U4uIW3mZIe+5I/U4a5iyOy
 ZTA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2022 16:54:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MCjd100DXz1Rwnx
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 16:54:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661385284; x=1663977285; bh=n8ZhrUtA1c9SLbu3PLJ3RAqq9nJ/TAUYRUu
        v91BkBEY=; b=f1xACxAD2meBuxrgUNNNK0WWY9vo65vXXLUC1OKWFZD6Mzz90QG
        bZscXU99tY0A3+9W7XyajucUjfGXGnfHejFI/glCTrPsg7hdVg43xy7zUpe2898W
        /PCscW2VA0Rtzw09muak6COLnNpZmrBwpHksVPhOZRrlFVK5zgDr4y9QPsXPZ9qL
        2rwjOCTuQOJatOczsaqX/s7HMix/WdpkBFKFdM/Zb1WH21kYD8ThNEchhfDMSpx/
        YEvs/a6xKm2uTu/LIIYct41TW12oiyFJuzk/jgfnjucpiRIpyUtZvGbHOfqRH7l4
        1Ygs8s9FbTtL6Mf1fjVKjp8GpP1/jEXmEtg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5LS3JAPq_FEp for <linux-acpi@vger.kernel.org>;
        Wed, 24 Aug 2022 16:54:44 -0700 (PDT)
Received: from [10.89.82.240] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.240])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MCjcz4kGGz1RtVk;
        Wed, 24 Aug 2022 16:54:43 -0700 (PDT)
Message-ID: <9c479bb6-bb57-9b5a-2fa5-7b4d1b840245@opensource.wdc.com>
Date:   Wed, 24 Aug 2022 16:54:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] ATA: ACPI: Do not check ACPI_FADT_LOW_POWER_S0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-ide@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <4426478.LvFx2qVVIh@kreacher>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4426478.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022/08/24 10:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The patch title should be "ata: ahci: ..."

> 
> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
> use low-power S0 idle on the given platform than S3 (provided that
> the latter is supported) and it doesn't preclude using either of
> them (which of them will be used depends on the choices made by user
> space).
> 
> For this reason, there is no benefit from checking that flag in
> ahci_update_initial_lpm_policy().
> 
> First off, it cannot be a bug to do S3 with policy set to either
> ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER, because S3 can be
> used on systems with ACPI_FADT_LOW_POWER_S0 set and it must work if
> really supported, so the ACPI_FADT_LOW_POWER_S0 check is not needed to
> protect the S3-capable systems from failing.
> 
> Second, suspend-to-idle can be carried out on a system with
> ACPI_FADT_LOW_POWER_S0 unset and it is expected to work, so if setting
> policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER is
> needed to handle that case correctly, it should be done regardless of
> the ACPI_FADT_LOW_POWER_S0 value.
> 
> Accordingly, drop the ACPI_FADT_LOW_POWER_S0 check from
> ahci_update_initial_lpm_policy().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/ata/ahci.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/ata/ahci.c
> ===================================================================
> --- linux-pm.orig/drivers/ata/ahci.c
> +++ linux-pm/drivers/ata/ahci.c
> @@ -1610,8 +1610,7 @@ static void ahci_update_initial_lpm_poli
>  	}
>  
>  #ifdef CONFIG_ACPI
> -	if (policy > ATA_LPM_MED_POWER &&
> -	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> +	if (policy > ATA_LPM_MED_POWER) {
>  		if (hpriv->cap & HOST_CAP_PART)
>  			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
>  		else if (hpriv->cap & HOST_CAP_SSC)
> 
> 
> 


-- 
Damien Le Moal
Western Digital Research
