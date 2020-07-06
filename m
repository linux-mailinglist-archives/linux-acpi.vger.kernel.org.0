Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCFD216145
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 00:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgGFWEr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 18:04:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46970 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725895AbgGFWEq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2020 18:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594073085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSaKePDZle72IIsbb8OTU+Jf3IEEa87RrzjMduxWjDA=;
        b=hNwC4vwIduxQu6Xxcmqm+6raq0ZyJ5a3Y8qaHvfAiPybOGewGNnjTfU/S2LLfd4Dbb+XEG
        wer92kHRL19fmBmb7+Ls46swVX+O6u2r0YPnZzoq8zerRZIdNDpoXecZ+tpKcZAh89Vr9l
        ycwSUKKgEEi74FoNdHTQo90eq8muFag=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-fiangetTPxqlJNd_l7ws9w-1; Mon, 06 Jul 2020 18:04:43 -0400
X-MC-Unique: fiangetTPxqlJNd_l7ws9w-1
Received: by mail-qt1-f198.google.com with SMTP id h10so15797788qtc.4
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2020 15:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=MSaKePDZle72IIsbb8OTU+Jf3IEEa87RrzjMduxWjDA=;
        b=o4iBDbd4gK4u72nM8bByS6oic449ET/4vh+YtF0FkSpft2VFiGHL7HrTo3ocuu0EX8
         jhef7eVhgE/3psfX5JdnHeZUmUDRwMu6QzRr1ucDiidG7+sop0PuAO539leqxPt3zi7W
         eXM8w+fiVoF3QvUMDpcwUnvVet1FyG3BVM7PHGaFl5LPvS2YcUiEoSyweEoMnQlpavVW
         k+sOMfvtowRmx4P5hRpfosfDGqn2o93pMLT64ChOut4uG6FM9fnj/EItsx6AblWqbyFA
         zoPiGCbA5M+JHzvJ9WZ0fVJSQn9/bnwM+Bq5DoY5iMFzsEaj27v9W4dzp35KHf5xqgiX
         fOYg==
X-Gm-Message-State: AOAM533NZ1tKpIxZ/GEC83XjjHxtr46gvtOaRuKCxtOSSd8EPg/6xTsJ
        ZgmqMEfrKyCYZgWnEKJrFIpDTq3oBwl/BC0eIHDNxaOF9y5JT9oYDiBjSsT3mQOFvqHy3zZJfk7
        1IEA2yLgvW4kPECl3ooWdFA==
X-Received: by 2002:ac8:1654:: with SMTP id x20mr37876342qtk.83.1594073082946;
        Mon, 06 Jul 2020 15:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvOU43xLsFZyXwqGMfGhqw/yW2xje7LPDpb4qxzz0sU5xjanrS4P3Dk5VdzPvK36hOokI7wg==
X-Received: by 2002:ac8:1654:: with SMTP id x20mr37876323qtk.83.1594073082687;
        Mon, 06 Jul 2020 15:04:42 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l202sm20315146qke.109.2020.07.06.15.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 15:04:42 -0700 (PDT)
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com> <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in TPM2 ACPI table
In-reply-to: <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
Date:   Mon, 06 Jul 2020 15:04:40 -0700
Message-ID: <87eepowb9j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Stefan Berger @ 2020-07-06 11:19 MST:

> From: Stefan Berger <stefanb@linux.ibm.com>
>
> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> to get the event log from ACPI. If one is found, use it to get the
> start and length of the log area. This allows non-UEFI systems, such
> as SeaBIOS, to pass an event log when using a TPM2.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/char/tpm/eventlog/acpi.c | 63 +++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 63ada5e53f13..3633ed70f48f 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -49,9 +49,9 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	void __iomem *virt;
>  	u64 len, start;
>  	struct tpm_bios_log *log;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		return -ENODEV;
> +	struct acpi_table_tpm2 *tbl;
> +	struct acpi_tpm2_phy *tpm2_phy;
> +	int format;
>  
>  	log = &chip->log;
>  
> @@ -61,23 +61,44 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	if (!chip->acpi_dev_handle)
>  		return -ENODEV;
>  
> -	/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> -	status = acpi_get_table(ACPI_SIG_TCPA, 1,
> -				(struct acpi_table_header **)&buff);
> -
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> -
> -	switch(buff->platform_class) {
> -	case BIOS_SERVER:
> -		len = buff->server.log_max_len;
> -		start = buff->server.log_start_addr;
> -		break;
> -	case BIOS_CLIENT:
> -	default:
> -		len = buff->client.log_max_len;
> -		start = buff->client.log_start_addr;
> -		break;
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		status = acpi_get_table("TPM2", 1,
> +					(struct acpi_table_header **)&tbl);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +
> +		if (tbl->header.length <
> +				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy))
> +			return -ENODEV;
> +
> +		tpm2_phy = (void *)tbl + sizeof(*tbl);
> +		len = tpm2_phy->log_area_minimum_length;
> +
> +		start = tpm2_phy->log_area_start_address;
> +		if (!start || !len)
> +			return -ENODEV;
> +
> +		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
> +	} else {
> +		/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> +		status = acpi_get_table(ACPI_SIG_TCPA, 1,
> +					(struct acpi_table_header **)&buff);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +
> +		switch (buff->platform_class) {
> +		case BIOS_SERVER:
> +			len = buff->server.log_max_len;
> +			start = buff->server.log_start_addr;
> +			break;
> +		case BIOS_CLIENT:
> +		default:
> +			len = buff->client.log_max_len;
> +			start = buff->client.log_start_addr;
> +			break;
> +		}
> +
> +		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>  	}
>  	if (!len) {
>  		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
> @@ -98,7 +119,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	memcpy_fromio(log->bios_event_log, virt, len);
>  
>  	acpi_os_unmap_iomem(virt, len);
> -	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +	return format;
>  
>  err:
>  	kfree(log->bios_event_log);

