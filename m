Return-Path: <linux-acpi+bounces-8539-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF10198E1F7
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 19:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BB61C22AFD
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5181D1E74;
	Wed,  2 Oct 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huooY8ej"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E41D1E73;
	Wed,  2 Oct 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891871; cv=none; b=qyI60Yowa0EONfi9K5yFNprMN0V7x/PKgSbcV3AdUCdghFao1S13OzKS5hzSFUsQIQA+GTI9o7IJFu73tJAZojgfrA4aJsl+det/mRGsBM6ulMZIm46adb2pUvL8e4vBcXK+KKhpH3wioUBf+aZIhT4M+Xrv6Ew5duPkmFhIplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891871; c=relaxed/simple;
	bh=A/S5/QVWoH+CfghPfUwCTbuDu30q7112Q1w5VlMlnc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCdI2w4/aKyfJ9QM/DK5eDd1gIz0KY2ooBy58354UE/fzLwxWalMNvHpsRyQrKR0tmsPhFTovul6p2PvXfvlNwBPzK9+dYHwGxRCk19fDhoA4PW5WMEfgX+5hDGKdrxRIf9XStrff24pJ90F1E/DnrsQ10U3WWW0O/Io2qBvxvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huooY8ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47785C4CEC2;
	Wed,  2 Oct 2024 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727891871;
	bh=A/S5/QVWoH+CfghPfUwCTbuDu30q7112Q1w5VlMlnc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=huooY8ejKK7OLjhzdj3lFaf9zEzxcvKjrYQY0FARZ10s3FUmoYA6pcWdeTV/xLfyS
	 8JeB7QZ/xWKOT6QiN8ux5nVSEWRuaexCIQPGRmEBrULFCAXxI8zId7Az6V24vtdWAC
	 IYIRCxfOVzuo3AbnaRq5hlVhSUUef/LSvTyQtL9xp1xTQ9oBHdsbo/HMUsd786h9IW
	 S1aY5yCPPkXe1E9RcQC2N3igIe7F4xsQLh6ClU8liBY0mHAtYRHDClUinxyanWUfdx
	 rXdzFfUO8F5zCLL5ZQ9YeHPZ2FbEIThDsIMITmPicZ8gdn59WlkgwrE5cQ+JtrItk9
	 P+9ENGD4FU/kw==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e033e37bc9so83325b6e.0;
        Wed, 02 Oct 2024 10:57:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXva5+n9BGtipkapLV6fV6ZcVU2sonQ9O2KfPHVNVxoMde9ls6Kdh43+OaTto4zk/KCBbzIP3WvCoBt@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAl3zdXwSdRTvJcHWaVqPveXFVX+8Amtpm6zn2NWvUiUOPQSG
	a1cTlTPj6h116jZbEO1fsd9vKiCVb/VbY8ucH/Oz5vmp0m2QUrRP/sUQVpszpFFwLFQ7FLDpmJ+
	2w1f8STkeD7oqkupSDE/TitB1kkY=
X-Google-Smtp-Source: AGHT+IFFsxhNk5Kb/U/K8CkqjanpxRFdHvapk4vEdL+SJ2cbmNzzKkSyQfQE11Jo4IwszvSSzCp7wYt9isFj3OeIfug=
X-Received: by 2002:a05:6808:10cb:b0:3e0:5d46:473a with SMTP id
 5614622812f47-3e3b40fa410mr2884686b6e.17.1727891870586; Wed, 02 Oct 2024
 10:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927142108.1156362-1-dave.jiang@intel.com> <20240927142108.1156362-2-dave.jiang@intel.com>
In-Reply-To: <20240927142108.1156362-2-dave.jiang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Oct 2024 19:57:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ieSWOduO4uhVecwLj=WHObn5A4GRewMygofXqEz-n=zw@mail.gmail.com>
Message-ID: <CAJZ5v0ieSWOduO4uhVecwLj=WHObn5A4GRewMygofXqEz-n=zw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] ACPICA: actbl1.h: Add extended linear address
 mode to MSCIS
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org, 
	bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com, 
	dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com, 
	ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 4:21=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
> ECN for "Extended-linear" addressing for direct-mapped memory-side caches
> adds a field in the SRAT Memory Side CAche Information Structure to
> indicate the address mode at the previously reserved bytes at offset 28.
>
> The field is described as:
> When Address Mode is 1 'Extended-Linear' it indicates that the
> associated address range (SRAT.MemoryAffinityStructure.Length) is
> comprised of the backing store capacity extended by the cache
> capacity. It is arranged such that there are N directly addressable
> aliases of a given cacheline where N is an integer ratio of target memory
> proximity domain size and the memory side cache size. Where the N
> aliased addresses for a given cacheline all share the same result
> for the operation 'address modulo cache size'. This setting is only
> allowed when 'Cache Associativity' is 'Direct Map'."
>
> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-=
xfh.jf.intel.com.notmuch/
> Link: https://github.com/acpica/acpica/pull/961

This pull request has been merged into upstream ACPICA, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm assuming that it will be routed through the CXL tree along
with the rest of the patch series.

Thanks!

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  include/acpi/actbl1.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 841ef9f22795..95ddc858a0c3 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1791,7 +1791,7 @@ struct acpi_hmat_cache {
>         u32 reserved1;
>         u64 cache_size;
>         u32 cache_attributes;
> -       u16 reserved2;
> +       u16 address_mode;
>         u16 number_of_SMBIOShandles;
>  };
>
> @@ -1803,6 +1803,9 @@ struct acpi_hmat_cache {
>  #define ACPI_HMAT_WRITE_POLICY          (0x0000F000)
>  #define ACPI_HMAT_CACHE_LINE_SIZE       (0xFFFF0000)
>
> +#define ACPI_HMAT_CACHE_MODE_UNKNOWN           (0)
> +#define ACPI_HMAT_CACHE_MODE_EXTENDED_LINEAR   (1)
> +
>  /* Values for cache associativity flag */
>
>  #define ACPI_HMAT_CA_NONE                     (0)
> --
> 2.46.1
>

