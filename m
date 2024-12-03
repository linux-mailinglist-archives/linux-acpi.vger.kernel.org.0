Return-Path: <linux-acpi+bounces-9895-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7C89E12FD
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 06:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC17164505
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 05:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA6B15573A;
	Tue,  3 Dec 2024 05:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6XwBjbr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87279AD51;
	Tue,  3 Dec 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733204952; cv=none; b=lzfNgKqEIP5CcpE4y/uutMLaYrfJEcDH6Gbw4tQ6dW5tqoXgCkPC9BNqL5qWd+eOZyw1taET+G1GiwvtvUO6BBvgw9npSOKBYDyjxFyQGJo7N2fxtzk7fMpmbMwjwgcKXoQvvo4Fujo8/HykFstRdgqV0/mTTwNMJRk286RWEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733204952; c=relaxed/simple;
	bh=9+OMis9UKzAs1KTRs1DRI10h/Hh/QDTQnZrrlwP6Z3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5iBNgitd9p94Km2DuNvYExlGuOtT7IOB34Cx9dFVugwjLBDLPoFVaJE0LGYIKlxocSot1+0/ni+5bsW0CDHp5pIBtha+3liO/IlMfMFjT+VkTUyCej3KNOJRLtuoSoweP4cOlh0ymvJNB2XaGT/Qz1sum5qTncbCM/ja0ZPQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6XwBjbr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2155312884fso33969695ad.0;
        Mon, 02 Dec 2024 21:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733204950; x=1733809750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwFomXOt4iVa8AmcJmu1prkQE7piY6I9wYCIltkzgzk=;
        b=m6XwBjbrWx8jAdTK2YIZWTijSyMOPwybV9LdTnnpo31pI/7us+YHJ4I0rlPVlGG8QC
         /g6yG0oLOlCeyH06f0FS1ELOYYuO9h5BypOBeENAknqImmlKzyS7Q271hVC6goiP4/Th
         60BYyB4bNjBgW39AW9bwoQ1wxoKV+ShqlJdzsGcq6ocrsYz86W+svO4/hD+jetNx3IwT
         ao8F6Mcfrmbplq4Js27ddUabBQU1Ql3+IRkBX7KU75kewwsd/Rfb3+yrbMAF9v+EJE/j
         boy12L+Njh36oWNQmZWuX3ud6Qv2IRYR4U2bOKsGFqtO3jpAEuggevKpEC8LnPx9cnwH
         UZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733204950; x=1733809750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwFomXOt4iVa8AmcJmu1prkQE7piY6I9wYCIltkzgzk=;
        b=pOk/uReW96PdjCzdo2Gmm9amhsqK5JF2eq+hvDx+O9iH3VJ4ilfpj+T/7R6KnIRY3c
         DPUpJhFu9MzspXP0kvtarMNtDdu6sLB+Kcj/j2GhQIT5/9GjDuaVzoNxtQKMsKQmCriG
         lZgFEiSGstkziCcHuenkLdxdvD88KYfm8+bOMx9uzgD05pCVzLadPH7b+PX2eioqyKOL
         9wUuSZ0CnAle6s8vHOfg3Fxm3+ap4qGX8SFyOH/aFNInEDRS++KAJaMciA07YL9kam2h
         XzcXqdmN4SqQ8pVxhleFf5eoQPppo5I/TmPKbPAOrqQwy9M2JSBoGcJNCSzYM1QmB43f
         Ls1A==
X-Forwarded-Encrypted: i=1; AJvYcCUDYPJfcQ29auKamTU07RpfxeFFfvDxBLm+/ac3x4AcfJC7zER85Ajr7iPpYGnnJefUXMOMqIIflmEx2N+/@vger.kernel.org, AJvYcCVNEIXBUpIjPSqRl+lJ6mgsBFLlEhbgss0qjHUKb7GlNbsfKRXXhQLz2EUrq40tbOK4c9hMjFvwORNI@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8RN7BnCc5sG4EhCyfL6CcEM18sBdUeaB8T5Li2k9fppVZXfS
	DIJ5FAObcBHm2/JkPrwZwzP9FPYwb2D2g9kqmmMjSS1mDlPaNI7B
X-Gm-Gg: ASbGncskVOeUme+I1BzsBeDaIoCzBabcnEiUxHxQH/2br4GRwqGX9CFpq9T/VUq/8rT
	yRkb15ZcRGmqdPEiks9L57SGN0Ip9WG9qeG2SjTUUsxkBd0i9uCg6ECu2yIBxWmc43QE+kzFDzc
	eqxoGJUyA8dStVGTN0RODOFNC/KrSmP69Cu1NA/U/4GXP3J86vYc1tCP6+YSwn0rOioXpjZh4LW
	o5ZO27vosda32fm+h6LOepwKgfcgczVPo0yum8ORFqCjvT6UKE=
X-Google-Smtp-Source: AGHT+IFpD/8itG95aHarOe27jSvd5jwJpIDjMcLKGRE6CqChWLoQrprl2NerCTFWHAsWca0H4qeKIw==
X-Received: by 2002:a17:902:e841:b0:215:9a6a:63cb with SMTP id d9443c01a7336-215bd200df9mr17196365ad.28.1733204949599;
        Mon, 02 Dec 2024 21:49:09 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:4077:b912:a87b:bbf9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152f396c2asm80636295ad.217.2024.12.02.21.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 21:49:08 -0800 (PST)
Date: Mon, 2 Dec 2024 21:49:06 -0800
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
Message-ID: <Z06b0oTvxUi4DTlx@google.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>
 <Z0j3EtRmYBmGFApu@google.com>
 <Z0nUpytu0GFUgQ9V@smile.fi.intel.com>
 <Z0q75n_P3sZYnviO@google.com>
 <Z0uHJJKMog-REw1D@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0uHJJKMog-REw1D@smile.fi.intel.com>

On Sat, Nov 30, 2024 at 11:44:04PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 29, 2024 at 11:16:54PM -0800, Dmitry Torokhov wrote:
> > On Fri, Nov 29, 2024 at 04:50:15PM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 28, 2024 at 03:04:50PM -0800, Dmitry Torokhov wrote:
> > > > On Thu, Nov 28, 2024 at 03:13:16PM +0200, Andy Shevchenko wrote:
> > > > > On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:
> 
> ...
> 
> > > > > > @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> > > > > >  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > > >  	struct fwnode_handle *next;
> > > > > 
> > > > > > -	if (IS_ERR_OR_NULL(fwnode))
> > > > > > +	if (IS_ERR_OR_NULL(fwnode)) {
> > > > > > +		fwnode_handle_put(child);
> > > > > >  		return NULL;
> > > > > > +	}
> > > > > 
> > > > > >  	/* Try to find a child in primary fwnode */
> > > > > >  	next = fwnode_get_next_child_node(fwnode, child);
> > > > > 
> > > > > So, why not just moving the original check (w/o dropping the reference) here?
> > > > > Wouldn't it have the same effect w/o explicit call to the fwnode_handle_put()?
> > > > 
> > > > Because if you rely on check in fwnode_get_next_child_node() you would
> > > > not know if it returned NULL because there are no more children or
> > > > because the node is invalid. In the latter case you can't dereference
> > > > fwnode->secondary.
> > > 
> > > Yes, so, how does it contradict my proposal?
> > 
> > I guess I misunderstood your proposal then. Could you please explain it
> > in more detail?
> 
> 
> Current code (in steps):
> 	if (IS_ERR_OR_NULL()) check
> 	trying primary
> 	trying secondary if previous is NULL
> 
> 
> My proposal
> 
> 	trying primary
> 	return if not NULL
> 	if (IS_ERR_OR_NULL()) check in its current form (no put op)
> 	trying secondary
> 
> After your first patch IIUC this is possible as trying primary will put child uncoditionally.

Ah, I see. No, I do not think this is a good idea: it will make the code
harder to understand for a casual reader: "Why do we check node validity
only after we used it for the first time?"

For the code not in a hot path there is a lot of value in simplicity.

Thanks.

-- 
Dmitry

