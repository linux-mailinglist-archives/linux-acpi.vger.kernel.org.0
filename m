Return-Path: <linux-acpi+bounces-9794-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA7C9DBDD7
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2024 00:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9A6281B3D
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 23:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669271C1F00;
	Thu, 28 Nov 2024 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXt0Ot6O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E104A14D6ED;
	Thu, 28 Nov 2024 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732835096; cv=none; b=MmojPboEGV24iXvWEIuk1YGRUQX6BsRzBnW28/pjQ+dLMhVc9vQmrhFG2unFgS2okPyjSaNVz01woQbtXGqMH/+tae+j++r47lqxs+6EnfF+P7N6X49VkEU1zM3hkDqjJyRFDhkkzjn6thEFYPJBQLVoy+nSNV2vhnFNnQJnDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732835096; c=relaxed/simple;
	bh=DzvCttm81qDVNPRzjk7KQALjH8dZtc2K3VkH6rbQ1JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js0Jxq7Sv5l6/OBi5dv3lvUZmCIAk1VQRRbGtWXCHsG5r5xKO0umNFE9x/bWl8hm68FQ/0/CIgCG3wrwclUahllZvRCQBjp2ICg13R4daSjwbzNW4DirIpD+FbP2bfP6lyZ159WaAy/TOzJWQ+azF8u2aB++E9XnDWgRQc5A4tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXt0Ot6O; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so716573a12.3;
        Thu, 28 Nov 2024 15:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732835094; x=1733439894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++cYjW+HqKSG3g8/MqoKxfKR3xnA0x2KXfB3k0N6Lsw=;
        b=AXt0Ot6O0qrECBKHYBPZRdaNt06iDWIrZyg9YwL/IDeIVJFvfHd227Fz32Bs7BVy5d
         dsETUESR/tUIWO6YlyamV6P/OyH77P9966yrTFsqk/0HnABxFads//Q3DVDeGW1M+j87
         l2Wf/G98VF8b3cE5vjnhAjnWtTQXfX/MGMti6ikwOEmYmsbhhdXhmWO1x4mTOHzlUlWH
         IKjePzkOQ7m6+ri0lxNYURHUgDi0jyAXFbgsdmu6aY9Z/iVoGxjc1j+VWsr3PkI8CrA7
         Ya0WME0x+Y2Dc8+UlDuPXFUHrjcc3EG8ECf88q98pefMeUw/+IvVVOMTy4SlTq/HLgbk
         aTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732835094; x=1733439894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++cYjW+HqKSG3g8/MqoKxfKR3xnA0x2KXfB3k0N6Lsw=;
        b=b2dqzEKYNlDECdru7gAWfCDU2jtKanIx2/i28Zo5aGNma29PmYhJcBhQC5LmOoIpJr
         yCC8OBvC1TS0YJ51WiDsdV3/UCq+kM8pqky1Yk/g52JKWNUHxW82pHiIDT2oxE/QdeAB
         io6kcprHtHZzFYrr6iyEPrOoEuwIKaDwu0y7A3IHF0rXBv6G/Bj7nnhhFqXQnDzZMxVs
         GBFqed4G8nPZGeMRvLEFRktBj8y5z/ZTw91ipz3PDe1TfHo/A0uqV4sZa2PyfEg2IXyn
         9Ofssch7X32Wt0HNoMyVZV1DElULduFKROxmlvs1HH8IsAz0ZnYlSmvPeqdex1pBHpsy
         mXXw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ouC8AA53czlqlrPdWKnuHqLe0Z4Fvbz/3ea655LKj69eXilPkxFNPDFojrDRqexFZ2VMjs2ZlL3f@vger.kernel.org, AJvYcCWccHQUfU8zBjuMHDesg/fDjEXrRzn5CVnJam7nbxKSVx8mx57rsdwX8Guy6hSqh1xalOmwJjGbUHijRsPE@vger.kernel.org
X-Gm-Message-State: AOJu0YxJP0K9+mjEy2fLeLDMCZOtIhMwbb1QQFnchTSNZQjFlazs+iwz
	chd4+9SI6kIbAD4GmkHnz3B4/sNRapRDfJNY7JLuxdmfKMGB4koI
X-Gm-Gg: ASbGncsdUAGvEa6owyZX9Sm5a1P0zaEAKtHemQHRYcUO05xDBMKHZRuBo5qy5yMYZOl
	ocXZYm62xK5mk7ziqkSpMqtiTVgPZY2yYNt7/yS7/kZdqjR9chuGCNTEpP/tdit9/EnUGvd3/yY
	OSefEnPlgz1sM+RwVfg1RxouohE6b7Uv1Q89M51sR+fANf7EL5xeyBDnYHQFZ1qI2GNa8NF27Em
	hMif3mnsP52otFe6w4O7SQzrxLDP19Nop/7ImAqycVpA4RoXg==
X-Google-Smtp-Source: AGHT+IE/aMZFGoNf0AnuLBoYsI4ZXZxfQV+WbNAJxb1A7vGSAkaUGS+6VHhxuOyc6Kz7vhvZ9x1t+Q==
X-Received: by 2002:a05:6a20:9185:b0:1e0:d618:1fe3 with SMTP id adf61e73a8af0-1e0e0b249a3mr12363438637.26.1732835094007;
        Thu, 28 Nov 2024 15:04:54 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:bb0d:3829:251:d17e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761500sm2201884b3a.29.2024.11.28.15.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 15:04:53 -0800 (PST)
Date: Thu, 28 Nov 2024 15:04:50 -0800
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
Message-ID: <Z0j3EtRmYBmGFApu@google.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>

On Thu, Nov 28, 2024 at 03:13:16PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:
> > The documentation to various API calls that locate children for a given
> > fwnode (such as fwnode_get_next_available_child_node() or
> > device_get_next_child_node()) states that the reference to the node
> > passed in "child" argument is dropped unconditionally, however the
> > change that added checks for the main node to be NULL or error pointer
> > broke this promise.
> 
> This commit message doesn't explain a use case. Hence it might be just
> a documentation issue, please elaborate.

I do not have a specific use case in mind, however the implementation
behavior does not match the stated one, and so it makes sense to get it
fixed. Otherwise callers would have to add checks to conditionally drop
the reference to "child" argument in certain cases, which will
complicate caller's code.

> 
> > Add missing fwnode_handle_put() calls to restore the documented
> > behavior.
> 
> ...
> 
> While at it, please fix the kernel-doc (missing Return section).

OK.

> 
> >  {
> > +	if (IS_ERR_OR_NULL(fwnode) ||
> 
> Unneeded check as fwnode_has_op() has it already.

Yes, it has, but that is not obvious nor it is a documented behavior of
fwnode_has_op(). It also different semantics: it checks whether a fwnode
implements a given operation, not whether fwnode is valid. That check is
incidental in fwnode_has_op().

They all are macros so compiler should collapse duplicate checks, but if
you feel really strongly about it I can drop IS_ERR_OR_NULL() check.

> 
> > +	    !fwnode_has_op(fwnode, get_next_child_node)) {
> > +		fwnode_handle_put(child);
> > +		return NULL;
> > +	}
> 
> >  	return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
> 
> Now it's useless to call the macro, you can simply take the direct call.

OK, will change to a direct call.

> 
> >  }
> 
> ...
> 
> > @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> >  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> >  	struct fwnode_handle *next;
> 
> > -	if (IS_ERR_OR_NULL(fwnode))
> > +	if (IS_ERR_OR_NULL(fwnode)) {
> > +		fwnode_handle_put(child);
> >  		return NULL;
> > +	}
> 
> >  	/* Try to find a child in primary fwnode */
> >  	next = fwnode_get_next_child_node(fwnode, child);
> 
> So, why not just moving the original check (w/o dropping the reference) here?
> Wouldn't it have the same effect w/o explicit call to the fwnode_handle_put()?

Because if you rely on check in fwnode_get_next_child_node() you would
not know if it returned NULL because there are no more children or
because the node is invalid. In the latter case you can't dereference
fwnode->secondary.

Thanks.

-- 
Dmitry

