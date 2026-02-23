Return-Path: <linux-acpi+bounces-21066-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAx1Cpt2nGmwHwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21066-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:47:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE66817902C
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EC05303B903
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFBB3093B5;
	Mon, 23 Feb 2026 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icTLiDqg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7853074AE
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861614; cv=none; b=scPAl6xOj5LZCguzt6Llf5A9GjXJ+eARf8OGZ4IpdDwWakK8xz6Co+txAByDgDR55avYfGpIIRmwQnqofFaGB8fW5wkCRSfleWxcwviTCqGTjb1ANq1NZmoU98V5tZDg4a3KYTx3GRZLOJf1QVdBHcNkTFP1wwuFw6yfHMOly/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861614; c=relaxed/simple;
	bh=OwsJXB6gmp+51u4gkX/upB/JmZ17y6He9o9hy9XvXIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twTiXicv6vG7wboud0Jc+4QFhXuJG5M5PGLsZ+fdaot6JimGUfIr6GnO4wWir8molkm/WU4cWRi1k/DLqtZ52OYAotdpU/L0PNyTswocZl+SRNRBT0N6yyaGPURT129ulQ657kcZVfRu/PpfrQW4TCuIkShqKw6qpiQ7ak5B6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icTLiDqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B0CC2BC9E
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861614;
	bh=OwsJXB6gmp+51u4gkX/upB/JmZ17y6He9o9hy9XvXIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=icTLiDqgGQ7kcDcujVK3v75S03E3/UEN+N0vEZwtIbIFpGXhvWV2SbtX5r6Y0GXbr
	 Q6Gupp8aWWHR7F6Q6L9cyUtrzUXxqCyKBtpjGt7raKyHuOSj6sr83XZGI/L236/8CK
	 SXkdyATnm7ihxvOP4QnZGCx8nbIIYzXVTTwxohCVgfk5WH5ldP0bcSC2eHxw0rSkpw
	 YXyv+VhgA3J54TuoSgkQZRYpk5fwnv9uBG3f8GU85pCuElkWgEYt8vhchNZFxBAhrD
	 mg+0jZMUQ20+DDlSQHiXJvshrS4gq2GMGdoB9EYdrVVr7j/Dfqgo8Nq8mgXYFG/w5m
	 Yt6ycdmB7rHOw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-385bc6910eeso42251921fa.2
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 07:46:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWd8LtoFdCvmWa0Bxz76Hix9d6U9ywV6R5mGw9B4bB8PuqJ+X+Of4u9o7VmVJgwfmNEIBAYFvQze0mZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGRDVODxTNbG9Q0S8zWId1+9JU1j0W1Dgjt7lA8wPDDGJDhOC
	b38ZGA1RA0dl5mvJ1Vn72ij+ccqb3C08grsKTyR/Ab/VgMA1gyz1Ka7TKRha/JyUI34SKAxHRKz
	n3JAq2Sazk4TCmRC9eOnbMuSXK/VufrJx7nV0mNiJFw==
X-Received: by 2002:a05:651c:3242:b0:387:b8d:60ee with SMTP id
 38308e7fff4ca-389a5e71eb2mr26870921fa.39.1771861612709; Mon, 23 Feb 2026
 07:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
In-Reply-To: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 23 Feb 2026 16:46:41 +0100
X-Gmail-Original-Message-ID: <CAMRc=MeD6rMQ2dU2mjS36=i3eXSs2HVG+qgAL3rsuvpQL0nCsQ@mail.gmail.com>
X-Gm-Features: AaiRm53u2VzxtaU8fDoU5Ly_le2s4UuFJ2dZdVbC4DtH8UHIknSGZH0qCCWbN1s
Message-ID: <CAMRc=MeD6rMQ2dU2mjS36=i3eXSs2HVG+qgAL3rsuvpQL0nCsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] driver core: provide and use device_match_fwnode_ext()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21066-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BE66817902C
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 4:41=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> In GPIOLIB, during fwnode lookup, after having resolved the consumer's
> reference to a specific fwnode, we only match it against the primary
> node of the controllers. Let's extend that to also the secondary node by
> exposing fwnode_is_primary() to drivers and reworking
> gpio_chip_match_by_fwnode().
>
> Link: https://lore.kernel.org/all/aZUIFiOYt6GOlDQx@google.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Forgot to pick up Linus' R-b:

Reviewed-by: Linus Walleij <linusw@kernel.org>

Rafael: is it fine if I take it through the GPIO tree?

Bart

