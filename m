Return-Path: <linux-acpi+bounces-3462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFD38541DD
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 04:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFF11F24761
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 03:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE185B654;
	Wed, 14 Feb 2024 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3YcoCss"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2110A01
	for <linux-acpi@vger.kernel.org>; Wed, 14 Feb 2024 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707882297; cv=none; b=nTiO6f/BNVPRPJ5NUtcWoyQ+astqX6rwcNdDLPy8vIDv53Ac4j6EdA2synDKzHJoPVY1QAfvE/Hx68ilOLwwb4UOTDmr5fhmmfBl5SDoIgZwBQTcv1Oi3Q4rXs+Txz2r7vkhM0bY8y+GVAs/gQ7VMtwpZ0cCnB1M20tJ+dVj80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707882297; c=relaxed/simple;
	bh=UUnUEzJ5jjH8ByEMpB5TAcY1gR1nRdoCWKhMnfRZjTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyXo5lYFkOwcNERsX1tlA6/8j0AgwXBvEoJZjE32laL7eTpOEvDbDDYk2j3t+FeLnO958fG+J3fsjnei51MQ1R22VSDhoqpkjtUSzQhquoP/ZeThx2DMamPaECgAg3kLLPyUZZy6/q9QwPihXKNUWVn3y1/BrfakURSvmU+c9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3YcoCss; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-428405a0205so577551cf.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 Feb 2024 19:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707882295; x=1708487095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdTms2KNxEQNoDVfOlewboipZEhREK6jYFWALQnd5FA=;
        b=U3YcoCss3f7/3PmjPae7nfgc799BQ8PwWHJeoQ1vQ/7amakQUxevj4Ht0mYjYbFUDk
         HEIVsy5UfvRD6j0SdV9kZSuV4SvRm7zx5eRcJ5lYf7+FQjBwAufRuVCP4wFzPrUSBQ6K
         uBGZmLYfBgwiHcuxTMalYiZfKaDhJCNtvkYV/+iBTmjaAe5R+DBVX3Px2PlUYlu8u+ur
         RKtPyjH5G8By6TwQt4g+JnbtTu/ibrDk0aXGWG8EYOYi0eZC1M2hiLLYBeqgcKwwQ15c
         ekJ6GhMK3BQmTtAzULAMXp8t1HagJK2KHoKLZsk7ab4dOrcmv/yeYUJmxRgfTL+0+6OQ
         96QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707882295; x=1708487095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdTms2KNxEQNoDVfOlewboipZEhREK6jYFWALQnd5FA=;
        b=WQ8VRo5fvRKhEZT3nJ8pkMonxAhohTW8M52a5JLN+CR2RFTohJGQoD3Y6/uHOM3etm
         PSjeb+P/fePpeQaxLH+ZWc82ZL3ZV06WDMuykzvavN+nBlOoijhFEu7ZmjgDBulz5LvO
         jp+tM98E4yb1MprlkexhKANU5XQCUBVZc4h0MvWBgWhLj5b3KRUVAnqWpg34ZgT2V43U
         TrRVT+yiAEU2MQ/A+rK28w0g0jUQrmGZl8kPtEI61/zWWZa2JPuocyM55HaJAIlsfvgf
         IozaBZm+gUAxlQ1KlO4t5ByO+2cBfDvSJjtzkoN+QlgRf6Vg12F1DPLyuBqw2E6oAqyI
         5XBw==
X-Forwarded-Encrypted: i=1; AJvYcCX339wHsoURYiOJscluMjtD2Et+Fg7BluywgjRSbIr/sp/qKXZ2G//iX4JuN8T8vgaZWEhPgcWpOJ77vgsJakjsSm4TLLQo8s48GA==
X-Gm-Message-State: AOJu0YwZuyuipr38hR8+USyjpa64tdfktTyo3scy+COSk+LPnTQYE6xo
	KaPIt12Zi1Q7zwwnmMxKeERSClsgjpMf6wKM6/0RfkIilNtH+OCrAKNhFsrqBImLJU6fWoZwAZK
	0eLtCLEe0EcPk/nem4QX2OGWNaM+tSNNWQc8s
X-Google-Smtp-Source: AGHT+IEtlCu0eM580Furc3rmgyMklSoe0aIdEca8lCSagMVKVqwdNppeUF13e/3urtg3bOPhQwYFfvnJjJyd9TaboDU=
X-Received: by 2002:ac8:4f49:0:b0:42b:f8ef:9d60 with SMTP id
 i9-20020ac84f49000000b0042bf8ef9d60mr137168qtw.19.1707882294841; Tue, 13 Feb
 2024 19:44:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
 <20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com>
 <aed988a09cb4347ec7ac1b682c4ee53b7d2a840b.camel@gmail.com>
 <20240213145131.GA1180152-robh@kernel.org> <48a86fa6908a2a7a38a45dc6dbb5574c4a9d7400.camel@gmail.com>
In-Reply-To: <48a86fa6908a2a7a38a45dc6dbb5574c4a9d7400.camel@gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 13 Feb 2024 19:44:16 -0800
Message-ID: <CAGETcx9xgLykm7Ti-A4+sYxQkn=KTUptW9fbFxgTcceihutwRQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: dynamic: flush devlinks workqueue before
 destroying the changeset
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 6:57=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Tue, 2024-02-13 at 08:51 -0600, Rob Herring wrote:
> > On Mon, Feb 12, 2024 at 01:10:27PM +0100, Nuno S=C3=A1 wrote:
> > > On Mon, 2024-02-05 at 13:09 +0100, Nuno Sa wrote:
> > > > Device links will drop their supplier + consumer refcounts
> > > > asynchronously. That means that the refcount of the of_node attache=
d to
> > > > these devices will also be dropped asynchronously and so we cannot
> > > > guarantee the DT overlay assumption that the of_node refcount must =
be 1 in
> > > > __of_changeset_entry_destroy().
> > > >
> > > > Given the above, call the new fwnode_links_flush_queue() helper to =
flush
> > > > the devlink workqueue so we can be sure that all links are dropped =
before
> > > > doing the proper checks.
> > > >
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > ---
> > > >  drivers/of/dynamic.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > > > index 3bf27052832f..b7153c72c9c9 100644
> > > > --- a/drivers/of/dynamic.c
> > > > +++ b/drivers/of/dynamic.c
> > > > @@ -14,6 +14,7 @@
> > > >  #include <linux/slab.h>
> > > >  #include <linux/string.h>
> > > >  #include <linux/proc_fs.h>
> > > > +#include <linux/fwnode.h>
> > > >
> > > >  #include "of_private.h"
> > > >
> > > > @@ -518,6 +519,13 @@ EXPORT_SYMBOL(of_changeset_create_node);
> > > >
> > > >  static void __of_changeset_entry_destroy(struct of_changeset_entry=
 *ce)
> > > >  {
> > > > + /*
> > > > +  * device links drop their device references (and hence their
> > > > of_node
> > > > +  * references) asynchronously on a dedicated workqueue. Hence we
> > > > need
> > > > +  * to flush it to make sure everything is done before doing the
> > > > below
> > > > +  * checks.
> > > > +  */
> > > > + fwnode_links_flush_queue();
> > > >   if (ce->action =3D=3D OF_RECONFIG_ATTACH_NODE &&
> > > >       of_node_check_flag(ce->np, OF_OVERLAY)) {
> > > >           if (kref_read(&ce->np->kobj.kref) > 1) {
> > > >
> > >
> > > Hi Rob and Frank,
> > >
> > > Any way you could take a look at this and see if you're ok with the c=
hange
> > > in the
> > > overlay code?
> > >
> > > On the devlink side , we already got the ok from Rafael.
> >
> > Didn't Saravana say he was going to look at this? As of yesterday, he's
> > also a DT maintainer so deferring to him.
> >
>
> Yeah, I did asked him but I guess he never had the time for it... Saravan=
a,
> could you please give some feedback on this? I think the most sensible pa=
rt is
> on the devlink side but I assume this is not going to be merged without a=
n ack
> from a DT maintainer...

Sorry for the delay Nuno. I'll get to this. I promise. This week is a bit b=
usy.

-Saravana

