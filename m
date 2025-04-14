Return-Path: <linux-acpi+bounces-13032-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB973A8888A
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB917A4F57
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8927FD54;
	Mon, 14 Apr 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz33TCc7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36D19F130;
	Mon, 14 Apr 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647908; cv=none; b=CuCDz4shXrffY+VfIV3kTWNd6psCrh6nCDoAJcxQiuzpSgT1x0EiwrkoutoQLSwJHfeIMJ6H70Ad9ZKlWS3XPu0PdDlpvJrvx/wl0VoV0B77Szf3/JNg+Om5zB7vhIuAK02J4WFc1MllHPHRHmWn+BHqJNeNCcn8Cr1Qgzd9Coc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647908; c=relaxed/simple;
	bh=4GavI1+TUHaY/auGcGgl6ajFXeqZhKPy5GPSBRjguLc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVoFWaYWkubYOuFQi/6LDf8f0bht5LGc+7LF8zY+UFPWeu3ZM34Wj6kynFLAoU4vw2QEJavkF2GE93DsJU3I3j8UyTbzXFOSI2NcMWEO0NzNAb1H1iR4AX9JKGoTse37d0g4960gAwavHT9SH02Irqj/hs0F8er5UBnOcbL1Q0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz33TCc7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-399749152b4so2447588f8f.3;
        Mon, 14 Apr 2025 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647904; x=1745252704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6TzHB9wqI4Z4IjYX+qsyY6yAP8RRCz8SzAbLTK3QFM=;
        b=Dz33TCc7/R1hA+BETrqFjvWiN3yeIWAOQn5wPSx5z46YxIkOvYT20vroIJVI3f6Tc5
         t3lkAycAOnx7E21yPlqzhcpTB9QeBuTCeA33Sh7dyctiXZieWDCWDI6qsR1vBxZNHyEv
         HQ5AuYwUvVJDXzwykn71GAJVJPwrk1UGlrcnps31aUT4P9lRyj290YH+meZAMScE3KlR
         cOX0O++Dca+l1VFOBm20JQzeNDB+WIrczoZlLxQjiHqIq2bbeXom2zF1pj0V3XIhps1b
         XIiF5QDeR7ltsgObqgKq9v9sLNwp7fqZ4pcYfG2lyHxhWN2gxMM8NqpfemzBp5ABIckM
         /dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647904; x=1745252704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6TzHB9wqI4Z4IjYX+qsyY6yAP8RRCz8SzAbLTK3QFM=;
        b=XBtofdK5jVcwOenK4TqqXFZUT8+wne+HgNCI184oaibDQD+rE//vvndpcbGxVEBi/e
         2bHAYrJ9NyWged4xDSl7xZ6KwXnbR8fDY7D9MbvsFbBXFy7hwmcF+GExvatkxq+HEENq
         r7HmOypUYjaPAmy0Gc0WLesKBce6e7knNW/zJIiKQLTgzCdPHYppqYUl4MPQlYGTYf1t
         v5jgQ1w9S6evA40RVMgTxNS0B8n8pDIf21gzWHIYF2r2nBZD9dmY4E3NzA4a4iPDnolB
         Z68q33Qnn93mvTc4IkZeeK3DrtZNV7D6dGzoKd9duruqOUDI0BdUX+3wjVM9PIebHow+
         bv+A==
X-Forwarded-Encrypted: i=1; AJvYcCWSC5WHBi7D9UauCtg11nqcRAJhUJQQ8kCi3GU1/S95mYF+y/BKKVv9oSOIQ+LuXLxga6advqQ1sGYq@vger.kernel.org, AJvYcCX0Yt/VnWsKVaym6B4Yu3cSAVimZgp8fPA3E9whO55hVBtmC5Sruv54HeBQz8+X5BSlpW91Oi8Hiazkp0zP@vger.kernel.org
X-Gm-Message-State: AOJu0YwrR1b21hRgPyBRZTlSU2L2cm3swcwCO5R3LAOadqmKz2vu1xuy
	YdCcfCbM6oLu4/9wQAL0sU8VYocEkobhCssmKQQldgypAauHNH0BTml71OVQhzk=
X-Gm-Gg: ASbGnctATqmx+BkpuaFgRncviIBfDM63Nlus7XqEI9l4cLMsK+acnEnJFK9+9qfxFHL
	DUQ+ApLPeUNIk5+IGR0ssacuGr5LvcOy/XezJtZ2u71RVz8QPSTcufmf+8GLZlUa/88LK7IsjIl
	VF7XLLObM3bimaBgESdFNyrfmGjcWy9FrNNK1KhPuH5NsXIUbQBxwV0DlcMJulzQNcJggnL71/Z
	vUvBia8yfvnS7TiBlOBwsNYLc03OrJHxcgpgIyBr3thohXRadefJhnvinmjGrW5Lf8cl2NstzNb
	K0iY0EhRDDRc49MJynzFLXWAVofO3Q4HNnTUGE63myXd
X-Google-Smtp-Source: AGHT+IHkZKXxX+remWMvdQHLVO0MZupgIBRz8YvABVN+xIyy4Qq2XhC0HDU5CGN3jzT6yP507wdd8g==
X-Received: by 2002:a05:6000:400a:b0:38d:b325:471f with SMTP id ffacd0b85a97d-39ea52035eemr10832220f8f.15.1744647903429;
        Mon, 14 Apr 2025 09:25:03 -0700 (PDT)
Received: from gmail.com ([103.210.134.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ce0asm11508888f8f.70.2025.04.14.09.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:25:03 -0700 (PDT)
Date: Mon, 14 Apr 2025 21:54:52 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ACPI: Fix building with GCC 15
Message-ID: <kjxkqexdkyesepwtyjsp2uuo73r65msvhl7ccxt77wv722gw3j@7ekim6v5clrh>
References: <20250414161644.30400-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414161644.30400-1-listout@listout.xyz>

On 14.04.2025 21:46, Brahmajit Das wrote:
> Since the Linux kernel initializes many non-C-string char arrays with
> literals. While it would be possible to convert initializers from:
>    { "BOOP", ... }
> to something like:
>    { { 'B', 'O', 'O', 'P' }, ... }
> that is annoying.
> Making -Wunterminated-string-initialization stay silent about char
> arrays marked with nonstring would be much better.
> 
> Without the __attribute__((nonstring)) we would get the following build
> error:
> 
> ...
> drivers/acpi/acpica/acpredef.h:903:11: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
>   903 |         {{"_S3D", METHOD_0ARGS,
>       |           ^~~~~~
> drivers/acpi/acpica/acpredef.h:906:11: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
>   906 |         {{"_S4D", METHOD_0ARGS,
>       |           ^~~~~~
> 
> and,
> 
> ...
> drivers/acpi/acpica/nsrepair2.c:115:10: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
>   115 |         {"_ALR", acpi_ns_repair_ALR},
>       |          ^~~~~~
> drivers/acpi/acpica/nsrepair2.c:116:10: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
>   116 |         {"_CID", acpi_ns_repair_CID},
> ...
> 
> Upstream GCC has added this commit
> 622968990beee7499e951590258363545b4a3b57[0][1] which silences warning
> about truncating NUL char when initializing nonstring arrays.
> 
> [0]: https://gcc.gnu.org/cgit/gcc/commit/?id=622968990beee7499e951590258363545b4a3b57
> [1]: https://gcc.gnu.org/cgit/gcc/commit/?id=afb46540d3921e96c4cd7ba8fa2c8b0901759455
> 
> Thanks to Jakub Jelinek <jakub@gcc.gnu.org> for the gcc patch.
> 
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  drivers/acpi/acpica/aclocal.h   |  4 ++--
>  drivers/acpi/acpica/nsrepair2.c |  2 +-
>  drivers/acpi/tables.c           | 28 +++++++++++++++-------------
>  include/acpi/actbl.h            |  3 ++-
>  4 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> index 6f4fe47c955b..d2cda1b35e59 100644
> --- a/drivers/acpi/acpica/aclocal.h
> +++ b/drivers/acpi/acpica/aclocal.h
> @@ -293,7 +293,7 @@ acpi_status (*acpi_internal_method) (struct acpi_walk_state * walk_state);
>   * expected_return_btypes - Allowed type(s) for the return value
>   */
>  struct acpi_name_info {
> -	char name[ACPI_NAMESEG_SIZE];
> +	char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));
>  	u16 argument_list;
>  	u8 expected_btypes;
>  };
> @@ -370,7 +370,7 @@ typedef acpi_status (*acpi_object_converter) (struct acpi_namespace_node *
>  					      converted_object);
>  
>  struct acpi_simple_repair_info {
> -	char name[ACPI_NAMESEG_SIZE];
> +	char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));
>  	u32 unexpected_btypes;
>  	u32 package_index;
>  	acpi_object_converter object_converter;
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
> index 1bb7b71f07f1..a28b1fa2b1ea 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -25,7 +25,7 @@ acpi_status (*acpi_repair_function) (struct acpi_evaluate_info * info,
>  				     return_object_ptr);
>  
>  typedef struct acpi_repair_info {
> -	char name[ACPI_NAMESEG_SIZE];
> +	char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));
>  	acpi_repair_function repair_function;
>  
>  } acpi_repair_info;
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 2295abbecd14..27104cbb48b5 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -396,19 +396,21 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
>  }
>  
>  /* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
> -static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
> -	ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
> -	ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
> -	ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
> -	ACPI_SIG_ASF,  ACPI_SIG_BOOT, ACPI_SIG_DBGP, ACPI_SIG_DMAR,
> -	ACPI_SIG_HPET, ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCFG,
> -	ACPI_SIG_MCHI, ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI,
> -	ACPI_SIG_TCPA, ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT,
> -	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
> -	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
> -	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> -	ACPI_SIG_NBFT };
> +static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst
> +	__attribute__((nonstring)) = {
> +		ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
> +		ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
> +		ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
> +		ACPI_SIG_ASF,  ACPI_SIG_BOOT, ACPI_SIG_DBGP, ACPI_SIG_DMAR,
> +		ACPI_SIG_HPET, ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCFG,
> +		ACPI_SIG_MCHI, ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI,
> +		ACPI_SIG_TCPA, ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT,
> +		ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
> +		ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
> +		ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> +		ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> +		ACPI_SIG_NBFT
> +	};
>  
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>  
> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
> index 451f6276da49..88ba1b978053 100644
> --- a/include/acpi/actbl.h
> +++ b/include/acpi/actbl.h
> @@ -66,7 +66,8 @@
>   ******************************************************************************/
>  
>  struct acpi_table_header {
> -	char signature[ACPI_NAMESEG_SIZE];	/* ASCII table signature */
> +	char signature[ACPI_NAMESEG_SIZE]
> +		__attribute__((nonstring)); /* ASCII table signature */
>  	u32 length;		/* Length of table in bytes, including this header */
>  	u8 revision;		/* ACPI Specification minor version number */
>  	u8 checksum;		/* To make sum of entire table == 0 */
> -- 
> 2.49.0
> 

Do I need to send the acpica part to GitHub first?

-- 
Regards,
listout

