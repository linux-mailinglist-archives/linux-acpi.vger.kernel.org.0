Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1B8BAFE
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2019 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfHMOA7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Aug 2019 10:00:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33422 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfHMOA7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Aug 2019 10:00:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so19894321otl.0
        for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2019 07:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Idmq9Ela+dAzEHfkXXgCpLtAAlGcGfcAq5nVbCa7csQ=;
        b=b8b9mBNdUe1FswywPoKhLuorcUV4N5oBuoc+yzZSu36Lm/idZJ73Hf87dA37ItLPFS
         iCUI6v7lLbKA3R7HdDeh0c9EXRqnbYKxADOfp8x+lZSbBiuNA6ZkqPucaSvf1M9SKSoZ
         WLfoPpEx9Zxzp6QujXCgPXGVer8iL7PccH3vpCeJh8m4GrU8GPWTgAjpQuJTblkwsv9a
         rTT/qEwXiHzMfFZLzXas5dc/b/a2xixGMgnep6kONKN5Si4bJ57Zq7NojvezRHuRGUAU
         bSi9sPkx8JLONTmpmJakt3c/I9ZyX5Ide+J4SYihgzWFkJBCcw4rBtnuaHbvhtpsLU3V
         gbow==
X-Gm-Message-State: APjAAAUmtcNcoaq/F2EptrpEiis8jmqzFVKTplgnHMAkOypmXmUQcnDs
        KWAlWYJCg6iLXv9ZrXJv9N02bA==
X-Google-Smtp-Source: APXvYqxcHGhMgSCYok78PR7yvPzptpT3YD5UEkb319vYu7Xf5HBHeeR+wgip9mNwQL4ltLXlzzt+uw==
X-Received: by 2002:a02:37c6:: with SMTP id r189mr32472750jar.118.1565704858100;
        Tue, 13 Aug 2019 07:00:58 -0700 (PDT)
Received: from masetto.ahs3 (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id v13sm10600441iol.60.2019.08.13.07.00.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 07:00:57 -0700 (PDT)
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH] ACPI / CPPC: do not require the _PSD method when using
 CPPC
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
References: <20190805170338.29493-1-ahs3@redhat.com>
From:   Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d60f5bed-ca91-fc72-2e4d-309fb8f42960@redhat.com>
Date:   Tue, 13 Aug 2019 08:00:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805170338.29493-1-ahs3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/5/19 11:03 AM, Al Stone wrote:
> According to the ACPI 6.3 specification, the _PSD method is optional
> when using CPPC.  The underlying assumption appears to be that each CPU
> can change frequency independently from all other CPUs; _PSD is provided
> to tell the OS that some processors can NOT do that.
> 
> However, the acpi_get_psd() function returns -ENODEV if there is no _PSD
> method present, or an ACPI error status if an error occurs when evaluating
> _PSD, if present.  This essentially makes _PSD mandatory when using CPPC,
> in violation of the specification, and only on Linux.
> 
> This has forced some firmware writers to provide a dummy _PSD, even though
> it is irrelevant, but only because Linux requires it; other OSPMs follow
> the spec.  We really do not want to have OS specific ACPI tables, though.
> 
> So, correct acpi_get_psd() so that it does not return an error if there
> is no _PSD method present, but does return a failure when the method can
> not be executed properly.  This allows _PSD to be optional as it should
> be.
> 
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  drivers/acpi/cppc_acpi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 15f103d7532b..e9ecfa13e997 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -365,10 +365,13 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
>  	union acpi_object  *psd = NULL;
>  	struct acpi_psd_package *pdomain;
>  
> -	status = acpi_evaluate_object_typed(handle, "_PSD", NULL, &buffer,
> -			ACPI_TYPE_PACKAGE);
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> +	if (acpi_has_method(handle, "_PSD")) {
> +		status = acpi_evaluate_object_typed(handle, "_PSD", NULL,
> +						    &buffer, ACPI_TYPE_PACKAGE);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +	} else
> +		return 0;		/* _PSD is optional */
>  
>  	psd = buffer.pointer;
>  	if (!psd || psd->package.count != 1) {
> 

Rafael,

Any other comments?  Would it be possible to pull this into an -rc?
I'd really like to avoid anyone else having to ship Linux-specific
DSDTs and SSDTs.

Thanks.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
