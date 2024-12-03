Return-Path: <linux-acpi+bounces-9905-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDFF9E2FB7
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 00:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C46B26FFC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 22:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5820125D;
	Tue,  3 Dec 2024 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSPqTcZk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8501362;
	Tue,  3 Dec 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265955; cv=none; b=eWxu19cBx4r17HeyY7fMMZn9mHPNQgfBR1i1XVCHBuNjs528Xn1lPk4elRJ9kvvf8gnNllNZnsO/ph1zNmbJrE1fPRWIh36C2wh3CpNzKLTrK2xnqxIWfPtQU2qHgxvN+F3k5AJKUrRBrH8/golQrgaNpNJjkRf1qNNq1sMJh08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265955; c=relaxed/simple;
	bh=m6NpZ3ovnhZVXttFIef8JZWvTJbel+ks2sRypWuw3Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P48wnqEtNVOAsErnl4a0p4BvvQsjcafm6gTYrRAmfvxxdfoIMP0J34ujPP4KXYL1MvAv1/Hf5bTbkky91+eKit6SFGGgpj1HigxS5xPomKSeqesHKVPpK4lRBd0Rz6pQxJjolTFJhA3aKmlRuAmQ4Dk04z2V86KTAjXnzna5be0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSPqTcZk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215666ea06aso2360635ad.0;
        Tue, 03 Dec 2024 14:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733265953; x=1733870753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pHx4DW5vGcFckyTuXNmycozltFpTrZCe9Z2pGfrUuF4=;
        b=TSPqTcZkvgKaTxF+IxIEwACX8HXwi+urZzoS6pdT6wxJszwqqIQNKTLf+ySVNG0u6m
         mlVi9YL3DCyyN0NX+jmC7I8L/X2ykqM5MrfmmUnGrl+ioVo7MnEBShuYjrPDc6GcvY+H
         J0eT6FnkQf8QgvHOh87jG2KRnUWtJK2RM4wcDk6huA5kdbx786YPzhnPLi5eIQO/+DfR
         gnoYa72JBx85BJk79IWqw5MDiwAnpk+YkMKsrnUjj9oeS+94y/XdXnvMiB3wYzte/Yyf
         wuZ0TLYR+lHSRWJ7OOUPgiLNq4CLqhEntWM9k196gH9mGHQJvUNumby3uiV9Wfpnllin
         43jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265953; x=1733870753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHx4DW5vGcFckyTuXNmycozltFpTrZCe9Z2pGfrUuF4=;
        b=SUyId6JQFKVNE7s4yUe/QMTmhd8SjcQjjeZXlIgxKVxzEnZ7sfgQVRCOER4XYiMVCv
         SdHfayQY079XaJ7eof7EzTeN9QuEy40ysW60b/5bC16mhhBZpB24LY72oMsnCW0+axCU
         5rTag5Xprj7eyExt2Dmdl0Vlc6CeGGr7H2v+AuIIbsEgTyvXqjheAUQOGp4yFOXuz1ff
         2cjOD0hjrUX3aOrnkAHYfpihA/ki9jB6fyJ5eTbTa40bNISc7oX2QWJEBFmoe/oDLef+
         w79/An6s80pMf4yzg2wVl2/KUqg5GzfswAUI1BPJaa+aUbh5VdnxnUZ+75Vqkhko4Vqw
         3YXA==
X-Forwarded-Encrypted: i=1; AJvYcCWRgDVKQUX9UEZeAEE3CifsS49s/hYMc3yK+hC6MpSuxJragZCycb1gfhTK4SQOtFD8rgxeqRfP4Ka8@vger.kernel.org, AJvYcCWaYl3mWeYZ9mz06Q4freSGzuwDRqVWrzFU3+IHtSdVKOgfmGRal5XFseqGn2EybPnhcQCvFaie6p3BL14R@vger.kernel.org
X-Gm-Message-State: AOJu0YzHiAPw0nHvJx/AGghiaNcmay0U5ygr8iihCnlv3I+ybJl/ejbg
	qk08N/024v2GoEHBOKIJ80xROgBawSHiWMHpYnQFNLthFCYOgZB5
X-Gm-Gg: ASbGncvP96+MJj1p5aAf4Esdg63ZYS2zDMMyF5CfatdqH4uwUT6w7HGIREeK5JKucH/
	qcJ53FT4qj3tkdjdRPbuRM4JaW8pGYXYnS+nFuR45pl7dGtDyxTRnLsCOM9VgwXQh0RGyd20WlG
	Sz0nf8etbU6enF+XjRWNj6DesLuHvMbg/mBS5ZYIK5iPzH1u2riNvTiR/StzunYkBCb2J4EXHAY
	uS6Q9f3isz6vZ4buQUOru5uoxzIbDUytL0k4mXensngUgRo4Tw=
X-Google-Smtp-Source: AGHT+IFNteVz+zDeTvojKEoPM0ZKuZcx4FTzyb15Sf/Huw+LEGghkyQG5vfjrGoV593uuDVF8tIZ3Q==
X-Received: by 2002:a17:903:22cf:b0:215:7287:67bb with SMTP id d9443c01a7336-215bd3c6b27mr75611715ad.0.1733265953178;
        Tue, 03 Dec 2024 14:45:53 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:a614:a365:7f4d:1d6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586986a4asm47603275ad.214.2024.12.03.14.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:45:52 -0800 (PST)
Date: Tue, 3 Dec 2024 14:45:49 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] device property: do not leak child nodes when using
 NULL/error pointers
Message-ID: <Z0-KHYnhu81ljbDk@google.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>
 <Z0j3EtRmYBmGFApu@google.com>
 <Z0nUpytu0GFUgQ9V@smile.fi.intel.com>
 <Z0q75n_P3sZYnviO@google.com>
 <Z0uHJJKMog-REw1D@smile.fi.intel.com>
 <Z06b0oTvxUi4DTlx@google.com>
 <Z08HQ2JmETJLNuud@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z08HQ2JmETJLNuud@smile.fi.intel.com>

On Tue, Dec 03, 2024 at 03:27:31PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 02, 2024 at 09:49:06PM -0800, Dmitry Torokhov wrote:
> > On Sat, Nov 30, 2024 at 11:44:04PM +0200, Andy Shevchenko wrote:
> > > On Fri, Nov 29, 2024 at 11:16:54PM -0800, Dmitry Torokhov wrote:
> > > > On Fri, Nov 29, 2024 at 04:50:15PM +0200, Andy Shevchenko wrote:
> > > > > On Thu, Nov 28, 2024 at 03:04:50PM -0800, Dmitry Torokhov wrote:
> > > > > > On Thu, Nov 28, 2024 at 03:13:16PM +0200, Andy Shevchenko wrote:
> > > > > > > On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:
> 
> ...
> 
> > > > > > > > @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> > > > > > > >  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > > > > >  	struct fwnode_handle *next;
> > > > > > > 
> > > > > > > > -	if (IS_ERR_OR_NULL(fwnode))
> > > > > > > > +	if (IS_ERR_OR_NULL(fwnode)) {
> > > > > > > > +		fwnode_handle_put(child);
> > > > > > > >  		return NULL;
> > > > > > > > +	}
> > > > > > > 
> > > > > > > >  	/* Try to find a child in primary fwnode */
> > > > > > > >  	next = fwnode_get_next_child_node(fwnode, child);
> > > > > > > 
> > > > > > > So, why not just moving the original check (w/o dropping the reference) here?
> > > > > > > Wouldn't it have the same effect w/o explicit call to the fwnode_handle_put()?
> > > > > > 
> > > > > > Because if you rely on check in fwnode_get_next_child_node() you would
> > > > > > not know if it returned NULL because there are no more children or
> > > > > > because the node is invalid. In the latter case you can't dereference
> > > > > > fwnode->secondary.
> > > > > 
> > > > > Yes, so, how does it contradict my proposal?
> > > > 
> > > > I guess I misunderstood your proposal then. Could you please explain it
> > > > in more detail?
> > > 
> > > 
> > > Current code (in steps):
> > > 	if (IS_ERR_OR_NULL()) check
> > > 	trying primary
> > > 	trying secondary if previous is NULL
> > > 
> > > 
> > > My proposal
> > > 
> > > 	trying primary
> > > 	return if not NULL
> > > 	if (IS_ERR_OR_NULL()) check in its current form (no put op)
> > > 	trying secondary
> > > 
> > > After your first patch IIUC this is possible as trying primary will put child uncoditionally.
> > 
> > Ah, I see. No, I do not think this is a good idea: it will make the code
> > harder to understand for a casual reader: "Why do we check node validity
> > only after we used it for the first time?"
> 
> Theare a re already a few API calls there that are hard to understand, I spent
> some time on them to get it through and still got it wrong as this series
> shows. So, I don't think we anyhow change this.

The fact that some code is confusing does not mean that we should add
more confusing code. We will not fix everything at once, but we can make
things better bit by bit.

Look, the check where it is now makes total sense, you added it there
yourself! It checks that we are dealing with a valid node and returns
early. The intent is very easy to understand and the only thing that is
missing is that "put" operation to satisfy the documented behavior.
Anything more just makes things more complex for no good reason.

> 
> > For the code not in a hot path there is a lot of value in simplicity.
> 
> If you really want to go to this rabbit hole, think how we can get rid of
> repetitive checks of the secondary or more if any in the future nodes in the
> list.
> 
> So the basic idea is to have this all hidden (to some extent) behind the macro
> or alike. In the code it would be something as
> 
>   for node in primary, secondary, ...
>     call the API
>     if (okay)
> 	return result
> 
>   return error
> 
> This will indeed help.

I think this will indeed help if we ever going to have more than primary
and secondary nodes. It is also tricky if you want to transition
seamlessly between different types of nodes (i.e. you have ACPI primary
with OF overlay secondary with swnode as tertiary etc). And you probably
want to add support for references between different typesof nodes
(i.e. swnode being able to reference OF device node for example).

This kind of rework is however out of scope of what I have time to do at
the moment.

Thanks.

-- 
Dmitry

