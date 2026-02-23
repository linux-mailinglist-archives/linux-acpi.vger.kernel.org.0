Return-Path: <linux-acpi+bounces-21064-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLipIVx2nGmwHwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21064-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:46:36 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02001178FE3
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38E8305BAAE
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF0C2F6565;
	Mon, 23 Feb 2026 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBZmyotX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4592F6188
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861372; cv=none; b=rcIS1czFcxPf2wxFO5dhDAS8fWXWJ+8gDi6F91ZVvVGMYuqvBIjaC2wADmCA6GTXP+MhvcK/AREc6SJWQUy04mAhrdixkt6pHLwzLkOpac5n4IMdBe18jWCsDuxG08qMd4S0EbLlwmKCIaZiNUh1M1xY66iluagTX8X3iPoEXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861372; c=relaxed/simple;
	bh=qwr/DFQQk+yd+ldphA8yc1rqqwRlXyH8faoME+O8oek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVKvM1Clnqx8D+wfnKjFSOjCBMHJPqvMce1hHgq9NJvF8hzpFK1j7X69IhElBGUTfNH6/M7d0J0pjZ9o6hex+SUSXuFrbk4LwV9GblUmwrWKbwuT+fZ3y87YFzf/2PgAxMcDxVfGIyhhw2eV1SmdBKm68mwqh1QO6Fnce9P9IBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBZmyotX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8518DC2BC9E
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861372;
	bh=qwr/DFQQk+yd+ldphA8yc1rqqwRlXyH8faoME+O8oek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EBZmyotXaBTFOgDtiKJG9Tc7RkZLFJt1Ez50p8NAGjynO0fu7X9+m2BrSETMoCpKU
	 JizNOA3oFRS4FiG9XPl1yvVsVgz+4bzgdGQ4xOeR+PXQrkjsUH2gbiA6kMclCCJdjF
	 L/8TD+EtkAhRLLQva2qH81LBxICOioy4iDkxJ5c/mocI4P8WMb2QPJsrFGNGgQBCbk
	 K16w077Di4AjYBntTipiFWu0Nlu5MAqbt/A9Aw1Er8ZWsMSaLdcczWEq2ZCXJmj1Sh
	 PN8YGX6445SUYGausQ+OUt0j7qigVZyuiBZ4SHkWXtCJsWD+/J26gaB6mhKqz9tHDJ
	 m38iCT0/42oGw==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c4b494fcso2522904a34.3
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 07:42:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKFU8/ix1uWU362nn1W0yEzUtfaEu85wuM7LOoI3m9pnu0ZvLxFQ2WMxbC9ffMsEDhYiMfWjTVXAYN@vger.kernel.org
X-Gm-Message-State: AOJu0YyCnTowZ8nnCT8RcvCtIi9rrEX6l2klxkY+6VKDUShIPqf6ixfk
	TKkp9Yn2ufAUijFAcQRLB8RDWDOeqCo5GJwxU+1QGlv66kMsxrA/72g5rTCVBYyElAtA6HdWReg
	OvkEh9XTdUC5uwbd6dZmBfI3ghB64aVg=
X-Received: by 2002:a05:6820:1513:b0:672:a49f:128c with SMTP id
 006d021491bc7-679c44f1c30mr4990922eaf.56.1771861371554; Mon, 23 Feb 2026
 07:42:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com>
In-Reply-To: <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 16:42:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hcF5R2OfckQrX9MBrPVebXXH8pZeWKySB2eiWQde8yzQ@mail.gmail.com>
X-Gm-Features: AaiRm51o-4ibpzQG2RoSbgSk5d3dRnGnaEGEZ5UK7M91aBX1SH7d5XpNcaXgPQU
Message-ID: <CAJZ5v0hcF5R2OfckQrX9MBrPVebXXH8pZeWKySB2eiWQde8yzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver core: make fwnode_is_primary() public
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21064-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 02001178FE3
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 4:41=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Export fwnode_is_primary() in fwnode.h for use in driver code.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/base/core.c    | 5 -----
>  include/linux/fwnode.h | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f599a1384eec90c104601422b04dc2b4c19d4382..2e551bbe591b09c66b113b419=
ba63f17e8bea94a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -5122,11 +5122,6 @@ int dev_warn_probe(const struct device *dev, int e=
rr, const char *fmt, ...)
>  }
>  EXPORT_SYMBOL_GPL(dev_warn_probe);
>
> -static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> -{
> -       return fwnode && !IS_ERR(fwnode->secondary);
> -}
> -
>  /**
>   * set_primary_fwnode - Change the primary firmware node of a given devi=
ce.
>   * @dev: Device to handle.
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 097be89487bf5c5a96f01d569c1691088db4f0ca..04db7f3ea50cceb9025c82c64=
49ba342d0e1b4a4 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -230,4 +230,9 @@ void fwnode_links_purge(struct fwnode_handle *fwnode)=
;
>  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
>  bool fw_devlink_is_strict(void);
>
> +static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> +{
> +       return fwnode && !IS_ERR(fwnode->secondary);
> +}
> +
>  #endif
>
> --
> 2.47.3
>
>

