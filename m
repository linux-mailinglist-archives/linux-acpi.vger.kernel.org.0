Return-Path: <linux-acpi+bounces-21094-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCfuHeC/nGlSKAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21094-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 22:00:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B4417D4EA
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 22:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 897FA3064F1C
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCEB3783D8;
	Mon, 23 Feb 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW+gRcDp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03E4A02
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771880413; cv=none; b=YCOmCJmi7nQh9h+sJtgYuQy11zbfAEK7nPDtBCMqFvKeykqCZKhP5l7Hv6/keRQeRXafY2o6ZKE/Y/vI74RmhBVsS1QM6bRS16oEqPk1ZcScKXI0YaPRl213PKevXAdJPejgT+UR+4Tu3CwYPb9vTw/Pji046id253h+BdoVKy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771880413; c=relaxed/simple;
	bh=aKIOPBEcPL7Dk1h/PGRlgq8uxS4h2Q3OebmeEXbtGrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXzrxBsVFW94Kxo7uj27Pq40X42nk+QtEV3eX9gzSyQd7xfYV4le27m0XP2hkgXE6O0ccKqlJeRhKQTlLPysCE2I6Ddltd2ZivuNGgwbEIx4FzxN17iIFHK4bw7iNEdv7flmV3/sWrQaN7xezhwajE85hOF9ifxxYNzn9Qlk6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW+gRcDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA02C2BC86
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 21:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771880413;
	bh=aKIOPBEcPL7Dk1h/PGRlgq8uxS4h2Q3OebmeEXbtGrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dW+gRcDpc+IaPOOMnWSjYgfsU46PqKyt4wynMqBWTXdnv5yCyb+/j6hzzlCPrjUxV
	 rM9EjbGfEYC7uf7xEJCg/JYNzOm2ot1zY4g7xUxTm83ID9AIDOLLaly7NE1pYmv7vn
	 uIeM93JmgIvnR8KLN4dNenr3xjLS+YzarY5qmf1P1o3jobWaapRom9Mm1AjVTlaf+I
	 mPf8gMKIQrdg4riXxWb+cstM4+khOcOONnbw9y47j0//dXTR2KSscjQ6KPFbRRh2wJ
	 l/EG7qnJA0816xvY3DcKtPQO2E80fMKw4pkS14owwztTwxPjRjtjOMmeiMsqTE0c61
	 Dgv2mg5EDAY4w==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4c9537f90so3181918a34.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 13:00:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXw19Xsv7RrMnnbV9ObxttC5sjQhC4luhfG3sjuqQMOoWIlBGM77sdVSiT17uCSZmBbqRCrK1pHToz9@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+9r+0gD3i1VBlIcLNmbpL/5ikbMrIfCH4bLW0onP6ZpkjKEX
	RuSedh22HYf+SP+65ffmz/vMWi4bhpSEWVQE67VFi6rU0GKkZEmtIfGxCySAdBsx6EHEcjC6/qB
	0W16FPQ80T7tbIUKNBBRpBgO759Oh80E=
X-Received: by 2002:a05:6820:828:b0:676:e8d1:bb55 with SMTP id
 006d021491bc7-679c4633dbfmr5559963eaf.59.1771880412242; Mon, 23 Feb 2026
 13:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com> <20260223204412.3298508-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260223204412.3298508-3-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 22:00:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jntUyx4DJ07sLtoa4RnnRWQb2xgmdRSNLyj7sFOReOoA@mail.gmail.com>
X-Gm-Features: AaiRm50Rx8zTucSDLsNIxMbDIuTm93F09BFbzR-XqIfRD_hGjwt2--dK8TBuUjw
Message-ID: <CAJZ5v0jntUyx4DJ07sLtoa4RnnRWQb2xgmdRSNLyj7sFOReOoA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] driver core: Split device link data types and API
 to device/devlink.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21094-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,lists.linux.dev,linuxfoundation.org,kernel.org,gmail.com,linux.intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: D7B4417D4EA
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 9:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> device.h is a huge header which is hard to follow and easy to miss
> something. Improve that by splitting device link data types and API
> to device/devlink.h.
>
> In particular this helps to speedup the build of the code that includes
> device.h solely for a device link data types and/or API.
>
> Note, get_dev_from_fwnode() goes to include/linux/fwnode.h as it seems
> better to be there (it is on one hand related to device link, but it
> is a getter for struct fwnode_handle respective field).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/device.h         | 86 +-----------------------------
>  include/linux/device/devlink.h | 97 ++++++++++++++++++++++++++++++++++

The name "devlink" is somewhat ambiguous (see
Documentation/netlink/specs/devlink.yaml), so it would be better to
use a full device_link name here IMO.

The change itself looks reasonable to me though.

