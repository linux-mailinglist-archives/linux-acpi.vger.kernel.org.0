Return-Path: <linux-acpi+bounces-771-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA8A7D05D1
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 02:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBB31C20AF4
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 00:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C97FB
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DwCEvpeV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB042923
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 23:06:48 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CA9124
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 16:06:46 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-581fb6f53fcso126532eaf.2
        for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 16:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697756806; x=1698361606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1n3bce8Qxuu7Ba2jFaCFgRD9TCUV2s+7y/RFVwamEpU=;
        b=DwCEvpeVXUfGsrXy6P4VMnQCCoM292F1h7bdgP+n7MoI+9Ue8H61cfhk1B55UBGPHo
         DvpAImZ7KWlgAecQHVASQ3q3ow+k5QBeOk90BwbGJJfr8QA0mD86ww7w0jqG0OC++nzM
         s/yQEVEi9sYbgJQ53lvOwMT7tpvA2QvCIe5FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697756806; x=1698361606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n3bce8Qxuu7Ba2jFaCFgRD9TCUV2s+7y/RFVwamEpU=;
        b=d/mm9MrpGMa5DueAZdLLAGpzDiIa19M80Ik5MgOGuzfEh92lkGmbsGdobsVM8sb2OR
         uXV/H8fvWIgCeRVNYYjeV6cmMDSX7HFSR3UrSmQK/XpZ/WB5BRzdyPWu09dsaZTbtSE7
         cg0JaN3MiN/O5OvT/drdljWw2gCEmS1lahW5IbbBNms1KBihJC8OIJjwLmVkxhojyKnt
         X0PwbBdzUY8iI+geDFOOCaUGyiiPUfXGu8woQ25y/PRNnbxynF2Zbbu3GcB9l7j7+4mG
         P3kvCWKRyqMJi0mYHRUgFFuoVbHVPXebg2SaXIg+7aflq4mf1a53OqszaSz3gmsPTDgH
         5ufQ==
X-Gm-Message-State: AOJu0YwaOHK0QAimT+CL4ZZ55LhG2DIR70cQlHWG9JX8Izu80S2sm3HV
	CmgUepxy5omzO3EntGRhXWTCgg==
X-Google-Smtp-Source: AGHT+IEhvEBOypzhBvUEC/LxnmQewUkvilNgMww7+1gCzs5lO9zQ2TaPhZ4dkppEJNjjFdom5AnCAg==
X-Received: by 2002:a05:6358:e4a0:b0:166:f18e:e60 with SMTP id by32-20020a056358e4a000b00166f18e0e60mr98593rwb.7.1697756805783;
        Thu, 19 Oct 2023 16:06:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7950d000000b0068ffd4eb66dsm301234pfp.35.2023.10.19.16.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 16:06:45 -0700 (PDT)
Date: Thu, 19 Oct 2023 16:06:44 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ACPI: replace deprecated strncpy with strscpy
Message-ID: <202310191606.93920741B@keescook>
References: <20231019-strncpy-drivers-pnp-pnpacpi-core-c-v1-1-4c634a73bcf3@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-strncpy-drivers-pnp-pnpacpi-core-c-v1-1-4c634a73bcf3@google.com>

On Thu, Oct 19, 2023 at 10:47:58PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We know dev->name should be NUL-terminated based on the presence of a
> manual NUL-byte assignment.
> 
> NUL-padding is not required as dev is already zero-allocated which
> renders any further NUL-byte assignments redundant:
> dev = pnp_alloc_dev(&pnpacpi_protocol, num, pnpid); --->
>   dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding. This simplifies the code and makes
> the intent/behavior more obvious.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks clean to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

