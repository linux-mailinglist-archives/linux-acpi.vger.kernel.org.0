Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC841135C0
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2019 20:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfLDTeB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Dec 2019 14:34:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44843 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfLDTeB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2019 14:34:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so574162wrm.11
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2019 11:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R9wL8wpMAQo3xs6Oo7Ut49Dor2Yx5BdeDObx5LbJwPk=;
        b=BsidMpTez6D8woWLrjk4lD+N4PUn7bJ5Ep5J41SGebwyU6FngHFbB84fGL1xkJWIZ8
         y7S2xC9wL4ZlN8GeGviYRczNoZMoYqDSSVY6q/3iH35HY4vfgmUGbxj8szlmd4XD5cH2
         ORdE8okd7WhhrBwPlmM9popbdZJ+BRt+sIBC+uoDdE7fWyaQMwlTUNW375dxyduppUMe
         qO15BmgiAAMjTzBQX8qn/scPJDzhYtUabPV6DkKYhKqXhFeZrMV3URBIqxBNW9z71fnb
         h4YLSEE9Y0lRvEzlXgQEazFWeSiOD4UYBt65i6d5wVmvMnTAomuosz+AtRNjeC3xdoYC
         OExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R9wL8wpMAQo3xs6Oo7Ut49Dor2Yx5BdeDObx5LbJwPk=;
        b=kbNltAx2tCpe0212kZ+Ph/BZeNk4Jp47V4o/LUJ+FZObE7DiLa3BjzG5ah2oSEhnZu
         ppCNhN2burtF9wHMgCSqFVbQsug4n6MkVeQrciapSTDN+7+IvWeO8exkHYO+Yzvo5vtm
         WuX+2raLg0P1ip37nbMezIQPsHrkTLQt60hIU4yfDNxvMYSb2X22uuJ9m1nXbWMjdDaS
         vK7DfJJ7lPJnsJNAfK7isT8bF67yatGMvACp2L8gTDvSo23klbDA7DId4AXBDbkmvfby
         EBVhSzRX2ITtMiC88PqtMMClMjDOyUs/JNFYQOG4e4G4dAJ3nHScieCFuSVipkO/BciQ
         SJAA==
X-Gm-Message-State: APjAAAV1lv6ZlU0pbWlznknpo6yRcSsaCPpgoLmJliwaOL2DxlLQqzCQ
        ajXJ2jFXvCn034lT41XfL4c=
X-Google-Smtp-Source: APXvYqwWCLDzh6Vw5gMPZzRKw5VHesp1uvSa5TtcsOb6MwBWmWn8l4mlVMkP872Yyg5lrg/uWFvIMQ==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr6131001wrn.356.1575488038221;
        Wed, 04 Dec 2019 11:33:58 -0800 (PST)
Received: from [192.168.2.202] (pD9E5AB36.dip0.t-ipconnect.de. [217.229.171.54])
        by smtp.gmail.com with ESMTPSA id v8sm7405220wrw.2.2019.12.04.11.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 11:33:57 -0800 (PST)
Subject: Re: PROBLEM: Calling ObjectType on buffer field reports type integer
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <3ef42aa1-196d-f3db-0e5d-2fd84c198242@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C59405C@ORSMSX122.amr.corp.intel.com>
 <fe4bcc1c-5c15-caa6-ce01-a5df962ff008@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5942CA@ORSMSX122.amr.corp.intel.com>
 <51e156ec-c2ed-84be-13c0-99a213e1d4b7@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C595C50@ORSMSX122.amr.corp.intel.com>
 <88077d9c-b2b7-5fc6-37e9-fa12d6aebe73@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C614AA8@ORSMSX122.amr.corp.intel.com>
 <c6511010-f160-a2ee-1b89-46df051a85e4@gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B196C@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A77@ORSMSX110.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C68481C@ORSMSX122.amr.corp.intel.com>
 <20f023a8-67f2-71dd-266d-700012c05b39@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C688D60@ORSMSX122.amr.corp.intel.com>
 <DM6PR11MB3612787F2B1143C658168A26F0420@DM6PR11MB3612.namprd11.prod.outlook.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <6fc2767d-4f48-dc7f-1bc1-6d0a2014b8f4@gmail.com>
Date:   Wed, 4 Dec 2019 20:33:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3612787F2B1143C658168A26F0420@DM6PR11MB3612.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/3/19 11:21 PM, Kaneda, Erik wrote:
> Hi Maximilian,
> 
> Please try the patch below:

Hi,

I've tested this on 5.4.1 and the current upstream master now.
Unfortunately it doesn't seem to fix the issue.

Specifically, it seems like the flag doesn't get set here
(printk-debugging indicates that the code in the if never runs):

>   /******************************************************************************
> diff -Nurp linux.before_name/drivers/acpi/acpica/dsutils.c linux.after_name/drivers/acpi/acpica/dsutils.c
> --- linux.before_name/drivers/acpi/acpica/dsutils.c	2019-12-03 13:36:21.782578718 -0800
> +++ linux.after_name/drivers/acpi/acpica/dsutils.c	2019-12-03 13:36:17.765579110 -0800
> @@ -470,6 +470,9 @@ acpi_ds_create_operand(struct acpi_walk_
>   			    ACPI_CAST_PTR(union acpi_operand_object,
>   					  walk_state->deferred_node);
>   			status = AE_OK;
> +			if (walk_state->opcode == AML_CREATE_FIELD_OP) {
> +				obj_desc->buffer_field.is_create_field = TRUE;
> +			}
>   		} else {	/* All other opcodes */
> 
>   			/*

That of course means that the if condition here is still not fulfilled,
so the problem is not fixed.

> diff -Nurp linux.before_name/drivers/acpi/acpica/exfield.c linux.after_name/drivers/acpi/acpica/exfield.c
> --- linux.before_name/drivers/acpi/acpica/exfield.c	2019-12-03 13:36:21.791578717 -0800
> +++ linux.after_name/drivers/acpi/acpica/exfield.c	2019-12-03 13:36:18.257579062 -0800
> @@ -153,12 +154,17 @@ acpi_ex_read_data_from_field(struct acpi
>   	 * the use of arithmetic operators on the returned value if the
>   	 * field size is equal or smaller than an Integer.
>   	 *
> +	 * However, all buffer fields created by create_field operator needs to
> +	 * remain as a buffer to match other AML interpreter implementations.
> +	 *
>   	 * Note: Field.length is in bits.
>   	 */
>   	buffer_length =
>   	    (acpi_size)ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->field.bit_length);
>   
> -	if (buffer_length > acpi_gbl_integer_byte_width) {
> +	if (buffer_length > acpi_gbl_integer_byte_width ||
> +	    (obj_desc->common.type == ACPI_TYPE_BUFFER_FIELD &&
> +	     obj_desc->buffer_field.is_create_field)) {
>   
>   		/* Field is too large for an Integer, create a Buffer instead */
> 

If I'm not mistaken I've proposed a patch here that is conceptually
quite similar (but may have some flaws or cause other issues, as I'm not
really familiar with the ACPICA code-base). My idea was to modify
acpi_ds_init_buffer_field (dsopcode.c) instead of
acpi_ds_create_operand. As said, I'm not sure however if this may have
any other consequences that I'm unaware of.

Also I've avoided creating an is_create_field flag by changing the field
access from AML_FIELD_ACCESS_BYTE to AML_FIELD_ACCESS_BUFFER (which
doesn't seem to be used anywhere else) and checking that, but the
general idea of extending the if condition in
acpi_ex_read_data_from_field is the same.

Link to the patch:
https://github.com/qzed/linux-surfacegen5-acpi/blob/2014964bac52f138109443de3e92dc2c6cff5e83/patches/5.3/0001-ACPI-Fix-buffer-integer-type-mismatch.patch

Thanks,
Maximilian
