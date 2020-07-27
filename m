Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB12222EC85
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jul 2020 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgG0MsP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jul 2020 08:48:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38244 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgG0MsP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2020 08:48:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RCfkxh076600;
        Mon, 27 Jul 2020 12:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0gKr0ymXUg0ZvifnNjIF8pHeTZQ6IDxLN6cZJfG0yYA=;
 b=UCmuaH6blPX2L3am4DAaF4ozZ3szwa0S+m7wiODPMD6p866bXHHdlaLzYVDqlcu7LnfD
 DQ5bIvK/3xIWE4ltYlJiNxju8dxVRRBOSY1vGEserD2uABJZcKVm+X5qFOz8fKixD8bN
 erqPWaGD86H0mutQREFBSvoBpEEU2Lvq27bedwbjcMwOVI5Uii3CEdlZlPGWQTl9PpKm
 DNrwiKRXjDva4fIXR+4/5cWCXocw3myakE0NxI55DvRRNVsgMDDPUQSkrGiVr7W+I/44
 AeWo31P5avnlOfZA/i6OME+FYmGzehrtzxxg6TZw8Q5lBxAWW2jexn28Om2D2Ut9lOPy 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32hu1j9a2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 12:48:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RChHHs169588;
        Mon, 27 Jul 2020 12:48:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32hu5qmrek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 12:48:10 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06RCm7vZ003346;
        Mon, 27 Jul 2020 12:48:08 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 05:48:07 -0700
Date:   Mon, 27 Jul 2020 15:48:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     garritfra <garritfranke@gmail.com>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, trivial@kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] trivial: acpi: replace some bitshifts with BIT macro
Message-ID: <20200727124800.GB1913@kadam>
References: <20200724160239.16284-1-garritfranke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724160239.16284-1-garritfranke@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=2 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=2 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270094
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch introduces two bugs, so perhaps don't send risky changes to
the trivial tree.

On Fri, Jul 24, 2020 at 06:02:39PM +0200, garritfra wrote:
> Signed-off-by: garritfra <garritfranke@gmail.com>

You need a commit message, and your full legal name for both the
From and the Signing.


> ---
>  drivers/acpi/acpica/exfldio.c   | 2 +-
>  drivers/acpi/acpica/utownerid.c | 6 +++---
>  drivers/acpi/bus.c              | 2 +-
>  drivers/acpi/sleep.c            | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
> index ade35ff1c7..92fc702456 100644
> --- a/drivers/acpi/acpica/exfldio.c
> +++ b/drivers/acpi/acpica/exfldio.c
> @@ -298,7 +298,7 @@ acpi_ex_register_overflow(union acpi_operand_object *obj_desc, u64 value)
>  		return (FALSE);
>  	}
>  
> -	if (value >= ((u64) 1 << obj_desc->common_field.bit_length)) {
> +	if (value >= ((u64) BIT(obj_desc->common_field.bit_length))) {

This breaks the code...  The original code casts 1 to 1ULL so we can
shift by 63 but the BIT() macro can only shift by 31.  It should use the
BIT_ULL() macro here.

>  		/*
>  		 * The Value is larger than the maximum value that can fit into
>  		 * the register.
> diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
> index d3525ef8ed..c4e2db2f54 100644
> --- a/drivers/acpi/acpica/utownerid.c
> +++ b/drivers/acpi/acpica/utownerid.c
> @@ -74,13 +74,13 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
>  			 * int. Some compilers or runtime error detection may flag this as
>  			 * an error.
>  			 */
> -			if (!(acpi_gbl_owner_id_mask[j] & ((u32)1 << k))) {
> +			if (!(acpi_gbl_owner_id_mask[j] & (u32)BIT(k))) {

This cast can be removed.

>  				/*
>  				 * Found a free ID. The actual ID is the bit index plus one,
>  				 * making zero an invalid Owner ID. Save this as the last ID
>  				 * allocated and update the global ID mask.
>  				 */
> -				acpi_gbl_owner_id_mask[j] |= ((u32)1 << k);
> +				acpi_gbl_owner_id_mask[j] |= (u32)BIT(k);
>  
>  				acpi_gbl_last_owner_id_index = (u8)j;
>  				acpi_gbl_next_owner_id_offset = (u8)(k + 1);
> @@ -171,7 +171,7 @@ void acpi_ut_release_owner_id(acpi_owner_id *owner_id_ptr)
>  	/* Decode ID to index/offset pair */
>  
>  	index = ACPI_DIV_32(owner_id);
> -	bit = (u32)1 << ACPI_MOD_32(owner_id);
> +	bit = (u32)BIT(ACPI_MOD_32(owner_id));

Remove.

>  
>  	/* Free the owner ID only if it is valid */
>  
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 54002670cb..39ead80c45 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -233,7 +233,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
>  		goto out_kfree;
>  	}
>  	/* Need to ignore the bit0 in result code */
> -	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
> +	errors = *((u32 *)out_obj->buffer.pointer) & BIT(0);

This removes the ~ so it totally breaks the code.

regards,
dan carpenter

