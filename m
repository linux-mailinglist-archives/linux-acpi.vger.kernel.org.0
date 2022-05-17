Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D55552A91C
	for <lists+linux-acpi@lfdr.de>; Tue, 17 May 2022 19:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiEQRWL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 May 2022 13:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239817AbiEQRWK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2022 13:22:10 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BEE26AEB
        for <linux-acpi@vger.kernel.org>; Tue, 17 May 2022 10:22:08 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HG1uRG013590;
        Tue, 17 May 2022 17:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=fbhNVkT48Leo+tZFX9eAH8IMVC1on/ZlIEy+NSeDomE=;
 b=Sp1M+O6VntiyD9b4vvVaZUZ/7dS3PWPUaQgAxmDL6ZT+GzyL95yM8hPJoy8RNnlh6a2G
 vlnzaYtR0SAaaQ82yb0Gk3g4rvH/53NfVDsimdTZdwSapQT28twx6wUKPNo6X88apEsk
 zhw0nY2aWkMwoTJMcBkwSKM4Fnz7y0fFouQm0upG/g+87sTvnEyqo/2wNDH/dTRIbOZs
 gPO5dDRb0wkaPnD3WoJOw0sxYbJY9iwpBzZwbdgc9UToubSBrWIFaP8LLX/COQQIA6L9
 KvJox3aHEG2spRdzWBEkhdpAV6E/q36g2Vcmrg219irIigcg/SCpXmc3rFp3t6IMa7OR wQ== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g4935dwnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 17:22:00 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 008EF51;
        Tue, 17 May 2022 17:21:59 +0000 (UTC)
Received: from ubuntu-20.04.3 (unknown [16.99.205.220])
        by g4t3433.houston.hpecorp.net (Postfix) with SMTP id 2603245;
        Tue, 17 May 2022 17:21:58 +0000 (UTC)
Date:   Tue, 17 May 2022 12:17:43 +0000
From:   James Liu <james.liu@hpe.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: OSL: Fix the memory mapping of an ACPI GAS that
 addresses a data structure
Message-ID: <20220517121743.GA4191@ubuntu-20.04.3>
References: <20220401172840.1252-1-james.liu@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401172840.1252-1-james.liu@hpe.com>
X-Proofpoint-GUID: Z7XdTE4jBqixaMoOyhHsFNn6mFr4d7V3
X-Proofpoint-ORIG-GUID: Z7XdTE4jBqixaMoOyhHsFNn6mFr4d7V3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 mlxlogscore=972 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170104
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael and all,
Could you take a look at this patch? The mentioned bug blocks EINJ testing
when a firmware can correctly support ACPI 6.4 spec. 

On Fri, Apr 01, 2022 at 05:28:40PM +0000, james.liu@hpe.com wrote:
> From: James Liu <james.liu@hpe.com>
> 
>     Modify acpi_os_map_generic_address and acpi_os_unmap_generic_address
>     to handle a case that a GAS table (i.e., Table 5.1 in ACPI 6.4) is used
>     to address a data structure; in this case, the GAS has the field of
>     "Register Bit Width" equal to 0.
> 
>     For example, "Injection Instruction Entry" (Table 18.25 in ACPI 6.4)
>     has a RegisterRegion field that is a GAS that points to a data
>     structure SET_ERROR_TYPE_WITH_ADDRESS (Table 18.30), which is required
>     when using EINJ (Error Injection module).
> 
>     This fix preserves a fairly sufficient memory space (i.e., page size)
>     to store the data structure so as to prevent EINJ module from loading
>     failure if platform firmware can support Injection Instruction Entry in
>     an EINJ table.
> 
> Signed-off-by: James Liu <james.liu@hpe.com>
> ---
>  drivers/acpi/osl.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 45c5c0e45..ab2f584b1 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -457,9 +457,15 @@ void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
>  	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		return NULL;
>  
> +	/* Handle a case that GAS is used to address an ACPI data structure */
> +	if (!gas->bit_width) {
> +		pr_info("An ACPI data structure at 0x%llx is mapped\n", addr);
> +		return  acpi_os_map_iomem(addr, PAGE_SIZE);
> +	}
> +
>  	/* Handle possible alignment issues */
>  	memcpy(&addr, &gas->address, sizeof(addr));
> -	if (!addr || !gas->bit_width)
> +	if (!addr)
>  		return NULL;
>  
>  	return acpi_os_map_iomem(addr, gas->bit_width / 8);
> @@ -474,9 +480,22 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
>  	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		return;
>  
> +	/* Handle a case that GAS is used to address an ACPI data structure */
> +	if (!gas->bit_width) {
> +		pr_info("An ACPI data structure at 0x%llx is unmapped\n", addr);
> +		mutex_lock(&acpi_ioremap_lock);
> +		map = acpi_map_lookup(addr, PAGE_SIZE);
> +		if (!map) {
> +			mutex_unlock(&acpi_ioremap_lock);
> +			return;
> +		}
> +		acpi_os_drop_map_ref(map);
> +		mutex_unlock(&acpi_ioremap_lock);
> +	}
> +
>  	/* Handle possible alignment issues */
>  	memcpy(&addr, &gas->address, sizeof(addr));
> -	if (!addr || !gas->bit_width)
> +	if (!addr)
>  		return;
>  
>  	mutex_lock(&acpi_ioremap_lock);
> -- 
> 2.25.1
> 
