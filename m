Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8477C216138
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgGFWCb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 18:02:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49203 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725892AbgGFWC1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2020 18:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594072946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TkXhzKLqTF0E87EA7fDsRKyQKfMvqiBc3obNNpfDHJg=;
        b=UQk6E3haVXC5DfU8/XFXkVlnLdrw2jGS5mAiTaUYBDKT4VEFH/SBYBdejvpvJ6vcK6h4nQ
        RUvt7o2Zjl8fneAwZGohToo5XLXcT/6IOQCTOZqi14GIdd4dCKEO3B3ni6Ic6nqydOLj2M
        r3eY+fERu0NKldLqbHhh4ltNypbFlag=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-ya5GXprnNBSIZyCOR3xHNg-1; Mon, 06 Jul 2020 18:02:17 -0400
X-MC-Unique: ya5GXprnNBSIZyCOR3xHNg-1
Received: by mail-qv1-f72.google.com with SMTP id m18so12647234qvt.8
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2020 15:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=TkXhzKLqTF0E87EA7fDsRKyQKfMvqiBc3obNNpfDHJg=;
        b=jnSOn7kMMkAlaR8B4Gt4pIqkPkXEci+sZOP3mbi1Zz5NWoL0j4kIdCf5amPoES7I9r
         bv3/sMCq5s7YxA2DATAlWpm/eJBEYOEZ+jLLHrJm0/2MB9K7Tr9l/PNZsNAYUuSwZmog
         czxsd14OjvPWGFh9xhBWTdbt2FiQ4Z+HRyxdQzESAy2vD8iNRE6Vc2+MU+wiqpaP/zfx
         c7Ggr78+V/+UVt+ZdaeHqqnQR1mgXZcV0JJx+6L7sF+ZMUpxunAyDej4G5ifJu124Znf
         R0VjMF8k6yysNEbdxXa00MvJ1idqldZ2TR7M4DHs7TlmH1dj7yP3npq1U9s0H1qDffKp
         8E+A==
X-Gm-Message-State: AOAM5321tbgc59J2g7g07+E88fGjOXYP0+1E3W3wKFB4H4/BnSLU8LlV
        wvm9tUViC2DYzutESwQgi+3lBCDvba10VyinMkBZqLHi3WinLgQMpiJX2SMukQAr3IZc1QN+VmW
        ouzGzUDssmr30hyCCL2Ye8g==
X-Received: by 2002:ae9:f002:: with SMTP id l2mr39136113qkg.437.1594072936809;
        Mon, 06 Jul 2020 15:02:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRP3z9E0tdvX8t39vt7/9u4f1ETvgBsRpRz2CaH0flMAo/xsbjQX5JZ47vfESsqw8doha+rA==
X-Received: by 2002:ae9:f002:: with SMTP id l2mr39136066qkg.437.1594072936430;
        Mon, 06 Jul 2020 15:02:16 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id a3sm20911329qkf.131.2020.07.06.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 15:02:15 -0700 (PDT)
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com> <20200706181953.3592084-2-stefanb@linux.vnet.ibm.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v9 1/2] acpi: Extend TPM2 ACPI table with missing log fields
In-reply-to: <20200706181953.3592084-2-stefanb@linux.vnet.ibm.com>
Date:   Mon, 06 Jul 2020 15:02:14 -0700
Message-ID: <87h7ukwbdl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Stefan Berger @ 2020-07-06 11:19 MST:

> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Recent extensions of the TPM2 ACPI table added 3 more fields
> including 12 bytes of start method specific parameters and Log Area
> Minimum Length (u32) and Log Area Start Address (u64). So, we define
> a new structure acpi_tpm2_phy that holds these optional new fields.
> The new fields allow non-UEFI systems to access the TPM2's log.
>
> The specification that has the new fields is the following:
>   TCG ACPI Specification
>   Family "1.2" and "2.0"
>   Version 1.2, Revision 8
>
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: linux-acpi@vger.kernel.org
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  include/acpi/actbl3.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index b0b163b9efc6..bdcac69fa6bd 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -415,6 +415,13 @@ struct acpi_table_tpm2 {
>  	/* Platform-specific data follows */
>  };
>  
> +/* Optional trailer for revision 4 holding platform-specific data */
> +struct acpi_tpm2_phy {
> +	u8  start_method_specific[12];
> +	u32 log_area_minimum_length;
> +	u64 log_area_start_address;
> +};
> +
>  /* Values for start_method above */
>  
>  #define ACPI_TPM2_NOT_ALLOWED                       0

