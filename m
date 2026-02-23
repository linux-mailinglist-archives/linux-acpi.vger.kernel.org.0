Return-Path: <linux-acpi+bounces-21083-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AW+NkWynGmxJwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21083-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:02:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CB117CA90
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5746430525DF
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD8374752;
	Mon, 23 Feb 2026 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH/sdQKe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213036605D;
	Mon, 23 Feb 2026 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876835; cv=none; b=OVmCU3wSBxvT/xaDTUpOxSdo8VaNt598an17QMZwPbcl1sN4RfCUmUExi7Q0sugbUgGvSwNcQHWB/uX8fAUBlDX+xmlCWWF+BkDdoQXFkV3CiZnb+MjGHqayPd2OpNFYdI8K/Ejh6u2jqtRFAhE2t9cBlePyh/JxVyi81COSglY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876835; c=relaxed/simple;
	bh=5I+GUkEiWucwoPTreVClRorAtsCzEOPlEM1kwCm2jLw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QxvRr4YLgwxZSbZHwigXbFc0Y1gkvjVlOzNcpknDLTcrfw/d/C0XZ9GylRSUj709ASGL/uB/iv0dAMPf5bm0jo7UyXlydMxGf25/Kuvhq1t0murbjqAGpFkPf6OXwL2vNVeHuipgTe5W4WuhAba/NKdLBfiqWveZug0YFHTBeBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH/sdQKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F598C116C6;
	Mon, 23 Feb 2026 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771876834;
	bh=5I+GUkEiWucwoPTreVClRorAtsCzEOPlEM1kwCm2jLw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uH/sdQKe4Ol6tA8XmSVURWXAoPeJ5zmZPoZJL5tWUbjqTqOQJZ//4Rm3h8SIYP4TY
	 A+x6YDmT8/ex2pq1J0YVyTPF/hlRpozhaVirjRJ5lPEr1zM6+VABa8nK3NILqiZ9Hg
	 nr79AlusDDcIcWsDekrEjTEPtIRSGRGtCGiyF8Uf/rrNAZ9VBNvld/Mzg+9VUjhb7u
	 jSAyt0LrjbhLcHXr19Y2GYVscjO+fUJgSeBqXS9bZFgWKhgZvzhdZEZPn0Vqtz1XEs
	 C5J1KMGI6qEVoECvVLkGeyA8ddRxqg9yL6H6kbhSUjlONjR/EayI629sT4T+0fpikX
	 poSrrVUiB5g5Q==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 21:00:30 +0100
Message-Id: <DGMLWYUO9Z48.1769AL2OS2YMK@kernel.org>
Subject: Re: [PATCH v2 2/2] gpiolib: match secondary fwnode too in
 gpio_device_find_by_fwnode()
Cc: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Walleij"
 <linusw@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>, "Dmitry
 Torokhov" <dmitry.torokhov@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Daniel Scally" <djrscally@gmail.com>,
 "Heikki Krogerus" <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Len Brown" <lenb@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com> <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com> <DGMLL6SYIK5C.DJ8U368VN9CG@kernel.org> <CAJZ5v0jr_i9k3d+np8c+ANhewMhT-TL9exLzZKUJOVarBGnHfw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jr_i9k3d+np8c+ANhewMhT-TL9exLzZKUJOVarBGnHfw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21083-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59CB117CA90
X-Rspamd-Action: no action

On Mon Feb 23, 2026 at 8:55 PM CET, Rafael J. Wysocki wrote:
> On Mon, Feb 23, 2026 at 8:45=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> On Mon Feb 23, 2026 at 4:40 PM CET, Bartosz Golaszewski wrote:
>> >  static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void=
 *fwnode)
>> >  {
>> > -     return device_match_fwnode(&gc->gpiodev->dev, fwnode);
>> > +     struct device *dev =3D &gc->gpiodev->dev;
>> > +     struct fwnode_handle *node =3D dev_fwnode(dev);
>> > +
>> > +     if (IS_ERR(fwnode))
>> > +             return 0;
>> > +
>> > +     if (device_match_fwnode(dev, fwnode))
>> > +             return 1;
>> > +
>> > +     return fwnode_is_primary(node) && node->secondary =3D=3D fwnode;
>> >  }
>>
>> Rafael, I understand [1] as you agree with my point, but object to intro=
duce
>> device_match_fwnode_ext() (or whatever name we would pick eventually :)
>> regardless because only the GPIO code would need it as by now.
>
> This is a preference, not a strong objection, but yes.
>
>> IIUC, I wonder if exposing fwnode_is_primary() instead is a good trade.
>
> Well, there is the secondary pointer in struct fwnode_handle, so it is
> kind of exported anyway and it could be documented as "a secondary
> fwnode_handle supplying additional properties or an error pointer", so
> exposing this static inline doesn't change much IMV.
>
> What's your specific concern about exposing it?

No concern with either approach from my side, I was just curious. :)

Maybe it makes sense to add a comment to gpio_chip_match_by_fwnode() hintin=
g to
move this into common code once there's another occurance of this pattern.

But either way, this is

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

>> [1] https://lore.kernel.org/driver-core/CAJZ5v0jUCtKTW-g-C0pKu0DQqOkyfSz=
=3DupXwbtYeV_=3DrMBUMyg@mail.gmail.com/

