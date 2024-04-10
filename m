Return-Path: <linux-acpi+bounces-4870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6718A01A8
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Apr 2024 23:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18111C23401
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Apr 2024 21:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10AF181D0B;
	Wed, 10 Apr 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClXzkN3C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23394181BBF
	for <linux-acpi@vger.kernel.org>; Wed, 10 Apr 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783104; cv=none; b=JT7xiJl//MqvNvu9idXiBIANAJC8yZ0MFZOZ2CmysZq3HG1qdyuFQlzvTzHpYBayGYYSLD2argEEnyngfBqqOF29S1ZLu7nZBmmDxPROgLxByLIYHBlkkoJrGCJkv2jtgIJYjvy05q0JCLwJ4sZFST523aMoBp9+5W5rv/2pDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783104; c=relaxed/simple;
	bh=Epm6y+/+ewLDaCEGj8jeg26lhCahwkzccVZSayI3ovA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIp58BKfvxTH+m71sFCHRfaz50eLa8IxgtTDoQtPqZy7zEPFaYGB8yARear0GF9lz7LefAIEduyEMUX+vt5npRGxLkYtDqbRR9o6y/0/hgq8yfk0M9OQSgbNto2z5qBbARPnhN7foZNN7Qrld0NLcs+pNzfaqB6BXqb6pcVLIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClXzkN3C; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d5e3fb7f2fso148901539f.0
        for <linux-acpi@vger.kernel.org>; Wed, 10 Apr 2024 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712783101; x=1713387901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qCz8E3Di/VZoyQ+H4jHMjBhox36aDiBbL8BntpRuyE=;
        b=ClXzkN3CyH68JwPDsy0+DSvqvlUeBgFiCVyW1luq/5p8gW4pbxN9TmiPIleb007RrW
         c51Itp4a6oVurrYQbySFE8PUDgdA3HTgVHUE23lxd64PF2PG44SVPBr+DFkSyvodr+dC
         mMtT3m8HXzjSWIetg3oGSrcK89oJTT8/Q6Sg+vAJCGwiV4cXLfePzMB1gNRlhBSo8Jbx
         FgZwFhZnFAbJKB6wS430FcNYM9Kuzt3gyYyAwUipV6V1rP243axEQr/cLxuGXGkO+x1j
         wEW2Almj7UUlcV2jLtyXtKTLv46i2fJqHLwBoVMTD5OeiWLWJcdNI0cPqJzzomD/19MN
         86JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712783101; x=1713387901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qCz8E3Di/VZoyQ+H4jHMjBhox36aDiBbL8BntpRuyE=;
        b=L09z8Cnionvfse/fytg4FY1dR6vkYeEMvX7iR2xlS69UwcXYIhLOlKzfVkLpNROopT
         5G8OIwZkxMi6LkA//eaHi+E3w8Kir07SDxM73kxZqarwZFdFzklO9tQGUQzo7CsEynb0
         eL8d6Od/2DUhO/Z30+/WMqd+KuYwb/0tWClgsJhEMlFaV5w7b/qYWh3EOQVKg1MWU2Wj
         KngtZTwk8x3A67PTM2ns4pX0az/fFbD8Ev2OnSSsAslbWFWbDJ/OS5gUDHQ1dqbaKxFM
         /Bi6y7neKGb22ZvKPcgz71hPy+7+cLNpDxDZ29Xmq9fmj2H1vrL8lZnb/I2Ztrgh8TwI
         j/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUoAPv7NwT4GufJy8Q1vFEvb92G3TPzno46dH7wUf9Mmq4ohTGYFNnXfixUFsa8Lcsf+YWnLJtZMzUmV8PeXTOBuW0Y3CCL/FykbQ==
X-Gm-Message-State: AOJu0YwPCt3j5kZJdJpqJSpKJG8CL9RrFcv0xz76tHu70gazMmjqeg+E
	jR6vCzpeYqLMUFj/FK5ZbqYaLSLu9gW/qmuQUs5YyAiBKwIraqFSfrCwVxv43Q==
X-Google-Smtp-Source: AGHT+IHN3/xecRCfid5g0bOH7LkZ8yJnDUd9LCUKGxMaS0A+hxkDrR8tOjgJoTgIYqX095KCqX+cBg==
X-Received: by 2002:a05:6602:4981:b0:7d0:c9c7:f52f with SMTP id eg1-20020a056602498100b007d0c9c7f52fmr5030577iob.6.1712783099842;
        Wed, 10 Apr 2024 14:04:59 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id n5-20020a05663831c500b0047be760081asm4119002jav.154.2024.04.10.14.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:04:59 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:04:54 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Russon <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Len Brown <lenb@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Lin Ming <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, 
	linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] [v2] test_hexdump: avoid string truncation warning
Message-ID: <fg6iv2dqwladc4d6tqzgg26mcyxz7c5bfn7gscic63c2qmhrz5@zvfm2btcf4fp>
References: <20240409140059.3806717-1-arnd@kernel.org>
 <20240409140059.3806717-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409140059.3806717-2-arnd@kernel.org>

On Tue, Apr 09, 2024 at 04:00:54PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc can warn when a string is too long to fit into the strncpy()
> destination buffer, as it is here depending on the function
> arguments:
> 
>     inlined from 'test_hexdump_prepare_test.constprop' at /home/arnd/arm-soc/lib/test_hexdump.c:116:3:
> include/linux/fortify-string.h:108:33: error: '__builtin_strncpy' output truncated copying between 0 and 32 bytes from a string of length 32 [-Werror=stringop-truncation]
>   108 | #define __underlying_strncpy    __builtin_strncpy
>       |                                 ^
> include/linux/fortify-string.h:187:16: note: in expansion of macro '__underlying_strncpy'
>   187 |         return __underlying_strncpy(p, q, size);
>       |                ^~~~~~~~~~~~~~~~~~~~
> 
> The intention here is to copy exactly 'l' bytes without any padding or
> NUL-termination, so the most logical change is to use memcpy(), just as
> a previous change adapted the other output from strncpy() to memcpy().
> 
> Cc: Justin Stitt <justinstitt@google.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This looks better than the previous strscpy() usage.

Acked-by: Justin Stitt <justinstitt@google.com>

> ---
> ---
>  lib/test_hexdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
> index b916801f23a8..fe2682bb21e6 100644
> --- a/lib/test_hexdump.c
> +++ b/lib/test_hexdump.c
> @@ -113,7 +113,7 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
>  			*p++ = ' ';
>  		} while (p < test + rs * 2 + rs / gs + 1);
>  
> -		strncpy(p, data_a, l);
> +		memcpy(p, data_a, l);
>  		p += l;
>  	}
>  
> -- 
> 2.39.2
> 

