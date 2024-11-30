Return-Path: <linux-acpi+bounces-9799-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE89DEF37
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 08:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD92162BFF
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 07:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEC113D8A3;
	Sat, 30 Nov 2024 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2gHjdDn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F13F9C5;
	Sat, 30 Nov 2024 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732951019; cv=none; b=f8g3Q5h6SWx5e8RSaakKE+Bc4YC5sS3zAEpPij22BUkNWQLJZzDOiFU1Yi3YK60G7rqmXeNdnP0fz6981WJtHiQvMhqGwoOym2w9trS5GpNqwYQ+cMCaf+EY5a0vtmeZajajEeqqE6vMlDFuljPC1Dq2H6iqa3JgDJLpEAcZ3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732951019; c=relaxed/simple;
	bh=YPCnbrP64JanOkjudn9XWBiJVO+GpdGpqUhfIgQsT54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3isTMAxtrnk8uj4g52543g7dIb0y+7hj9m/XxuUcH8dxLQ8xZdDkmhtfL1rUE3zKGu//lGC5aTZTnSe9MsGuWIyqjWweIk93rsMeqFQ+Wz4PKx4YUdDZbW4UMpPfpTOsZjm7HaSr1uMRAAYtOY8QHcc5pFiqhDGHWm9qywSZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2gHjdDn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724e14b90cfso2555578b3a.2;
        Fri, 29 Nov 2024 23:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732951017; x=1733555817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqQbDGPCUKIKYz6Sian8M3jZTVR/g5zr9cseBhm98KQ=;
        b=P2gHjdDnE8AldUqrNmMgllyux735ns0ZJyDCBzkp8AQV+o+mHFIslSegCGPSsWF5a3
         aLlS8+Pqv4XLicmy5/hm/I2X8coy9qLXerIEvKPp45qjlc0u0SboKFF+abtg4ibY6Bzp
         qqOmlVYPHl11SnAq+zDS3CQr2KzEWYwRSTJncyMHa32YbO2Mj0q8RQ9jiNSSD/gWpN6H
         Y3pLxFGxwLl8YeZ46y3zS+YjzB3lUzrelJu5AtGLDW8R79eXFE01C5ZdVhPff2KhrCRz
         F7FrhHqo5mm23QTawPeS+30nk3iXSJ3uU6zXt9cxCAD6iL4EKcR+S1EztZYZYGogL8xX
         1eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732951017; x=1733555817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqQbDGPCUKIKYz6Sian8M3jZTVR/g5zr9cseBhm98KQ=;
        b=M1shOmxrmTDv6ZEjKRHLXWil3C3WlQPBFe31kkcV/ezieML1pFfitDyADfbdaepCSG
         gCYHlR/8MU0g7uacqO3frVCJA3AL//1Jy0Sarw62QajxjaLJOnQorMtCLPvMANQ6aIXf
         gUIiLe/lnVaAD/jQpSpOnSf2MsIlKy2UJ5gXg1teRZe+gz0LUwMEO6gQw5onh5rZmYM1
         keao0yfIYK66VoYY05p/8MCgZ4slr6gOCJZegbbgDRW4Tg2thrWYPsNLjIo+S1joDlTa
         MwjqZ2atvd4k3gKUkQdP8XaLGdqXW1Uqv/qzITYuFOw88TpGZFaRNVhZlAAmb1YxyvB1
         Husg==
X-Forwarded-Encrypted: i=1; AJvYcCUYxt0z7CFLfnckDOhP9k5EtcUwXsmrqgFSqczHp6ej7+1ujqA+1APfCjozU+7Z+eHxjTKbKHyqJTf0@vger.kernel.org, AJvYcCWGkWRDBCJN7yzZm0VxM3byu4BlowPRTdtxXoooJ5X0v+XDGomldsnc3MvPnxOU3r5xPtWLMMGEw12Jwq5B@vger.kernel.org
X-Gm-Message-State: AOJu0YyRS1jgIzcNd4N7lqVtpj8s0OCxyFLxOhrVcJH6fCNdc4RBVpl3
	yfH4qcpoF75ITJxv33LZPSpB2RDn+hl98H9j1wYcb5c3Zv4V1VTh
X-Gm-Gg: ASbGncvRDNCNMRh3oIvcihusEZEOrMK/yD4Jd+dA1WRF/fVjcTJSBbPZoHEXOzkmH6/
	He6R9eMadG83SL75XV4O6wTQoRZFfbUFc8ulcJEr73UX4zQ31IAHmk0mlBTOKcr+46+U+tAI7f9
	fQsslDP7hUIhbu5PlLnAIy7p558P/c4JbA5cEwhBq/2qxUVgJVvWfty34Prmo+wATpvi3/F8JPq
	xSXmDHXyrJadY7thp8mRdcAUdzkbQodnmi0KArd2LfOyuHdbg==
X-Google-Smtp-Source: AGHT+IE03fl6m3ou3CGtIN8NONjPAahGDyvoYhoCMDPOGM+8aXxuHgCxPIm0oOLGHDOihdtuVLVwCA==
X-Received: by 2002:a17:903:2350:b0:211:31ac:89f7 with SMTP id d9443c01a7336-21501286a81mr170691145ad.26.1732951017134;
        Fri, 29 Nov 2024 23:16:57 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:3654:66e:a1de:ebbd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21544fd9b4dsm21060525ad.223.2024.11.29.23.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 23:16:56 -0800 (PST)
Date: Fri, 29 Nov 2024 23:16:54 -0800
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
Message-ID: <Z0q75n_P3sZYnviO@google.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>
 <Z0j3EtRmYBmGFApu@google.com>
 <Z0nUpytu0GFUgQ9V@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0nUpytu0GFUgQ9V@smile.fi.intel.com>

On Fri, Nov 29, 2024 at 04:50:15PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 28, 2024 at 03:04:50PM -0800, Dmitry Torokhov wrote:
> > On Thu, Nov 28, 2024 at 03:13:16PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:
> > > > The documentation to various API calls that locate children for a given
> > > > fwnode (such as fwnode_get_next_available_child_node() or
> > > > device_get_next_child_node()) states that the reference to the node
> > > > passed in "child" argument is dropped unconditionally, however the
> > > > change that added checks for the main node to be NULL or error pointer
> > > > broke this promise.
> > > 
> > > This commit message doesn't explain a use case. Hence it might be just
> > > a documentation issue, please elaborate.
> > 
> > I do not have a specific use case in mind, however the implementation
> > behavior does not match the stated one, and so it makes sense to get it
> > fixed. Otherwise callers would have to add checks to conditionally drop
> > the reference to "child" argument in certain cases, which will
> > complicate caller's code.
> 
> Perhaps this should be somewhere between the cover letter / commit message?

OK, I thought that it was pretty obvious, but I will expand the commit
message to include this.

> 
> > > > Add missing fwnode_handle_put() calls to restore the documented
> > > > behavior.
> 
> ...
> 
> > > >  {
> > > > +	if (IS_ERR_OR_NULL(fwnode) ||
> > > 
> > > Unneeded check as fwnode_has_op() has it already.
> > 
> > Yes, it has, but that is not obvious nor it is a documented behavior of
> > fwnode_has_op().
> 
> Would like to document that then?
> 
> > It also different semantics: it checks whether a fwnode
> > implements a given operation, not whether fwnode is valid. That check is
> > incidental in fwnode_has_op().
> 
> I kinda disagree on this. The invalid fwnode may not have any operations,
> so it's implied and will always be like that.

Yeah, it is clear that we disagree. I agree that invalid fwnode will not
have an operation defined, still checking whether an operation is
supported and whether a node is invalid or not are 2 different
operations to me. But we do not need to argue further.

> 
> > They all are macros so compiler should collapse duplicate checks, but if
> > you feel really strongly about it I can drop IS_ERR_OR_NULL() check.
> 
> Yes, please drop it and rather we want fwnode_has_op() to be documented with
> main purpose and guaranteed side effect (the latter makes no need of
> duplication that I pointed out).

OK.

> 
> > > > +	    !fwnode_has_op(fwnode, get_next_child_node)) {
> > > > +		fwnode_handle_put(child);
> > > > +		return NULL;
> > > > +	}
> 
> ...
> 
> > > > @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> > > >  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > >  	struct fwnode_handle *next;
> > > 
> > > > -	if (IS_ERR_OR_NULL(fwnode))
> > > > +	if (IS_ERR_OR_NULL(fwnode)) {
> > > > +		fwnode_handle_put(child);
> > > >  		return NULL;
> > > > +	}
> > > 
> > > >  	/* Try to find a child in primary fwnode */
> > > >  	next = fwnode_get_next_child_node(fwnode, child);
> > > 
> > > So, why not just moving the original check (w/o dropping the reference) here?
> > > Wouldn't it have the same effect w/o explicit call to the fwnode_handle_put()?
> > 
> > Because if you rely on check in fwnode_get_next_child_node() you would
> > not know if it returned NULL because there are no more children or
> > because the node is invalid. In the latter case you can't dereference
> > fwnode->secondary.
> 
> Yes, so, how does it contradict my proposal?

I guess I misunderstood your proposal then. Could you please explain it
in more detail?

Thanks.

-- 
Dmitry

