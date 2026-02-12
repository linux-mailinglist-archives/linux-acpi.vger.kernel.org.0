Return-Path: <linux-acpi+bounces-20950-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNYHIg/BjWlt6gAAu9opvQ
	(envelope-from <linux-acpi+bounces-20950-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 13:01:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E171012D3B0
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 13:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B715530F164F
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE49354ACC;
	Thu, 12 Feb 2026 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoaWklEQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAB3542ED
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770897619; cv=none; b=tEV0qC7Nhk9gihCj7CNSbRBWnx9WrmP2aPDF6w2vCTU+Dja169qfp2ycQwIlLoANI3acphtRtA4HZgbooT5GNbSJNnqZ+cTac1wJfX90pNKl1vG4S5jNFpLPFtP8ZJe7JGBMHgg0ZS0ngkaZ+g+ulyg6sa98UPnP1nCt0XlyiNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770897619; c=relaxed/simple;
	bh=/9fzX1FIeyFKMfmdibQk2ZzEBtDaKcIkc8f0e+/BPYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ecn++M1de+PUrK6xa8LasyUoa5p8NXKVtiFSNe2tWonDiWMjssa6RFPfArS65y1jshplE67yU8uzRS/3LaDDXjyQAvW71wcSkhcLv4tmAA2VaimVJnMlnDZWC4+Hv0UYfh/afTNQU8K4qQXV6wrfk8Tg6tdbnbkohH4Y3GVA5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoaWklEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CDDC4CEF7
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770897619;
	bh=/9fzX1FIeyFKMfmdibQk2ZzEBtDaKcIkc8f0e+/BPYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BoaWklEQA7RQNp4zUcpRGxBWZ5pbNCot32xeI+q5JwNUKMQxkRp3Bhwqjq8gUrvo/
	 IeX3SYzQnr3hXliu+9AX2WgTRTO6G7ChLQteHQoo1oYS+fyq31m+bm01dIGuhojyZg
	 Sg3X7rbfIIFCtPcj92UwR9uURVNZT3OyTj71b/+IR8sX5rT0TIW+q0td53dobVtD7C
	 NBjeHkrA/F+mmk7v+lX/USlR5FgyJHOzfiQCkg/4mARwLmrSG8vxRqO2+p7NAwil7p
	 Mpd8SZTZpXMGDn/XofyhqLuBODtWUWKl5n+ipg3FQXIlE+FnzcyrZJ/9dT+9OiR7i8
	 0Xsn+TgcuKS9A==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-408778a8ec4so2552138fac.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 04:00:19 -0800 (PST)
X-Gm-Message-State: AOJu0Yyd4LiS62L4PuTjheRGA4PVrQXJZ9cDz7FoaHd1LYj63vwc6jmA
	8YuxHdToMzbBpfG6MGF2RPfB64iOuZ3+fIS0UX8+1G2HYewPwYH7YESl8xpjF2aV1mCtsFiFU31
	EUFMIHmFqbnKJAqGPhZfp2nSfAMS7TvU=
X-Received: by 2002:a05:6871:20c6:b0:2e9:93c6:6e4a with SMTP id
 586e51a60fabf-40eca282ebemr1017635fac.38.1770897618642; Thu, 12 Feb 2026
 04:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Feb 2026 13:00:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jZ=jya8LK4mOZATnoDr9raA-M=ZuV89RyPkAZ2Beecog@mail.gmail.com>
X-Gm-Features: AZwV_QiYzkz3nsO-m35CjZgxkZYP35-Ch_Gf9Qz7-zUfAglxUWL4Kj48O5PoNj4
Message-ID: <CAJZ5v0jZ=jya8LK4mOZATnoDr9raA-M=ZuV89RyPkAZ2Beecog@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Allow secondary lookup in fwnode_get_next_child_node()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Driver core list <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.intel.com,linuxfoundation.org,kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20950-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E171012D3B0
X-Rspamd-Action: no action

Cc: driver-core

On Tue, Feb 10, 2026 at 2:58=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When device_get_child_node_count() got split to the fwnode and device
> respective APIs, the fwnode didn't inherit the ability to traverse over
> the secondary fwnode. Hence any user, that switches from device to fwnode
> API misses this feature. In particular, this was revealed by the commit
> 1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
> that effectively broke the GPIO enumeration on Intel Galileo boards.
> Fix this by moving the secondary lookup from device to fwnode API.
>
> Note, in general no device_*() API should go into the depth of the fwnode
> implementation.
>
> Fixes: 114dbb4fa7c4 ("drivers property: When no children in primary, try =
secondary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/base/property.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 6a63860579dd..8d9a34be57fb 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -797,7 +797,18 @@ struct fwnode_handle *
>  fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
>                            struct fwnode_handle *child)
>  {
> -       return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
> +       struct fwnode_handle *next;
> +
> +       if (IS_ERR_OR_NULL(fwnode))
> +               return NULL;
> +
> +       /* Try to find a child in primary fwnode */
> +       next =3D fwnode_call_ptr_op(fwnode, get_next_child_node, child);
> +       if (next)
> +               return next;
> +
> +       /* When no more children in primary, continue with secondary */
> +       return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node,=
 child);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
>
> @@ -841,19 +852,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_no=
de);
>  struct fwnode_handle *device_get_next_child_node(const struct device *de=
v,
>                                                  struct fwnode_handle *ch=
ild)
>  {
> -       const struct fwnode_handle *fwnode =3D dev_fwnode(dev);
> -       struct fwnode_handle *next;
> -
> -       if (IS_ERR_OR_NULL(fwnode))
> -               return NULL;
> -
> -       /* Try to find a child in primary fwnode */
> -       next =3D fwnode_get_next_child_node(fwnode, child);
> -       if (next)
> -               return next;
> -
> -       /* When no more children in primary, continue with secondary */
> -       return fwnode_get_next_child_node(fwnode->secondary, child);
> +       return fwnode_get_next_child_node(dev_fwnode(dev), child);
>  }
>  EXPORT_SYMBOL_GPL(device_get_next_child_node);
>
> --
> 2.50.1
>

