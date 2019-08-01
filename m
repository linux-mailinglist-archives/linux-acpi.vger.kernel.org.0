Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0B7E330
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2019 21:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfHATQY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Aug 2019 15:16:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46163 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388231AbfHATQY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Aug 2019 15:16:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id r4so52842646qkm.13
        for <linux-acpi@vger.kernel.org>; Thu, 01 Aug 2019 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5t3tzqXqpNbdKtPEsmdz9Dwf6r6pNTpWJhNvYjQG3h4=;
        b=A8/G7jLpfTgWadsEuB/dl0+Z3G3BWFlweQBVY1yMVtyNgidSuRKVOD5NLpfvbzBoQl
         Jxg6iXbYPCsTP7otqAHyNwF+tG3vwKTo2Nn7xzSAHpDS0Q/XMRNZuwJ7hlq4DtT+7R0O
         RtOF5zxB6zAo28I7gSVJsacqmeJ/bUlChSE1raHV6axfUoBIPrDJH0sWABXqS0odxz7r
         lJTEGA4UnGeuLdxwkP54y154QbH4j5pwN7I5eH6SyZwM1pnPmBWiUXpjU50JfMGhL7hF
         BvhAapZSg0WnouNpqVkx+bYXXWNTyGvL9UOwrlrtTJPaaz2BSdhsnTlUH+ZBI+2zXJ/A
         TozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5t3tzqXqpNbdKtPEsmdz9Dwf6r6pNTpWJhNvYjQG3h4=;
        b=kBLXdbb0Gok9JZxnbEbYWk0XHr/uq72+zPRPoJJd6lG15Tt0VCF4EyVZg5D6YDhOBr
         mcc0mDaz+VMoVKaXGGKVB3NK/Bu+ycJ1e4YYGAYASzUYbRsxDzeBZT7sIcNwifjRIfTt
         EFUVMh/JKHsA6Lk17esp227558q/ZIEYp0dSDNtb5eUckQ/II2ksoP3XfUkurv0fGgAM
         2JJ4aAtKrp1E8PtAh8hXP1xZ64ARdC+/5EjgvXlDkxK+E0nzZks4vDj7/Elfe2tOeDTI
         Sp7XUI0BBWAC+HmXB/1aLY4M1QeBlDDPqlk7Xed2gAuLcn3XZcR4zVr/9MhldMTNJ/05
         xXOA==
X-Gm-Message-State: APjAAAW42AjsYHVyHgBZZUgChIS/XLnJkSCd9GTcfXh/uYcADAmUrja1
        TZh3d5Ltb7+jCMO0o8hOuxq9Bw==
X-Google-Smtp-Source: APXvYqwM7On48Iw3/mNYaF1NUbOCZVmS3TGeF0EMRVlHSC1fsLS/im9rYTx4L2OgDwy5PG98GWwuYg==
X-Received: by 2002:a05:620a:1404:: with SMTP id d4mr87089021qkj.228.1564686983047;
        Thu, 01 Aug 2019 12:16:23 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c5sm33070187qkb.41.2019.08.01.12.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 12:16:22 -0700 (PDT)
Message-ID: <1564686979.11067.48.camel@lca.pw>
Subject: Re: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
From:   Qian Cai <cai@lca.pw>
To:     "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "jkim@FreeBSD.org" <jkim@FreeBSD.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Aug 2019 15:16:19 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661CBD@ORSMSX110.amr.corp.intel.com>
References: <20190718194846.1880-1-cai@lca.pw>
         <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661CBD@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2019-07-26 at 19:35 +0000, Moore, Robert wrote:
> We've taken the change to ACPI_TO_POINTER.

I am a bit confused here. I saw the commit in the acpia repo.

https://github.com/acpica/acpica/commit/02bbca5070e42d298c9b824300aa0eb8a082d797

but how does that change will go into the linux kernel? Suppose Rafael will need
to pick it up manually?

> 
> 
> -----Original Message-----
> From: Qian Cai [mailto:cai@lca.pw] 
> Sent: Thursday, July 18, 2019 12:49 PM
> To: Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> Cc: Moore, Robert <robert.moore@intel.com>; Schmauss, Erik <erik.schmauss@inte
> l.com>; jkim@FreeBSD.org; lenb@kernel.org; ndesaulniers@google.com; linux-acpi
> @vger.kernel.org; devel@acpica.org; clang-built-linux@googlegroups.com; linux-
> kernel@vger.kernel.org; Qian Cai <cai@lca.pw>
> Subject: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
> 
> Clang generate quite a few of those warnings.
> 
> drivers/acpi/scan.c:759:28: warning: arithmetic on a null pointer treated as a
> cast from integer to pointer is a GNU extension [-Wnull-pointer-arithmetic]
> 		status = acpi_get_handle(ACPI_ROOT_OBJECT,
> obj->string.pointer,
>                                          ^~~~~~~~~~~~~~~~
> ./include/acpi/actypes.h:458:56: note: expanded from macro 'ACPI_ROOT_OBJECT'
>  #define ACPI_ROOT_OBJECT                ((acpi_handle) ACPI_TO_POINTER
> (ACPI_MAX_PTR))
> 							^~~~~~~~~~~~~~~
> ./include/acpi/actypes.h:509:41: note: expanded from macro 'ACPI_TO_POINTER'
>  #define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0,
> (acpi_size) (i))
>                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/acpi/actypes.h:503:84: note: expanded from macro 'ACPI_ADD_PTR'
>  #define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t,
> (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
>                                          ^~~~~~~~~~~~~~~~~
> ./include/acpi/actypes.h:501:66: note: expanded from macro 'ACPI_CAST_PTR'
>  #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
>                                                                  ^ This is
> because pointer arithmetic on a pointer not pointing to an array is an
> undefined behavior (C11 6.5.6, constraint 8). Fix it by just casting the
> corresponding pointers using ACPI_CAST_PTR() and skip the arithmetic. Also,
> fix a checkpatch warning together.
> 
> ERROR: Macros with complex values should be enclosed in parentheses
>  #45: FILE: include/acpi/actypes.h:509:
> +#define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, i)
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: Use ACPI_CAST_PTR() in ACPI_TO_POINTER() directly without
>     arithmetic.
> 
>  include/acpi/actypes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> ad6892a24015..163181e2d884 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -506,7 +506,7 @@ typedef u64 acpi_integer;
>  
>  /* Pointer/Integer type conversions */
>  
> -#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0,
> (acpi_size) (i))
> +#define ACPI_TO_POINTER(i)              (ACPI_CAST_PTR (void, i))
>  #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
>  #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void
> *) 0)
>  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
> --
> 2.20.1 (Apple Git-117)
> 
