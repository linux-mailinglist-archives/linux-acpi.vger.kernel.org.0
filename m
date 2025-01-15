Return-Path: <linux-acpi+bounces-10647-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11EA11774
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 03:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FECA7A04B9
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 02:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA16D22DC30;
	Wed, 15 Jan 2025 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSrMeluC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB713AC1;
	Wed, 15 Jan 2025 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736909126; cv=none; b=TcB5NeeclK6n4okYBCuIqAZ2JZycUoDMFZBGrZge7OIbYve/JQOJUiLhuHOfCBwh0VNPuRpleBZCsc8q6cGKQuqIQRYFOsJmx0Ilk216DdwDUIyPXkBGUBB1muGr2eNP985l8c2Es0EZ+ytXVzbccxfVMipwfN8nubSOPPI899g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736909126; c=relaxed/simple;
	bh=eiyR3aj5jzMdBC6LfKr01SptLl4AjrYP7uJny0YBM6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4QLuMrwUgdfheUVjAohyzHRzcPoPkqTWnxXeYCqQAquCqXrbDhUTL6+l1xx4+Fq3HS/CCGOteyRVWTvRkWElvoDMXE5Lj0/cvg0j/q/050c5PNNNE/S5TAMcZO9RTGTgIw7ZXTvJPVXYPdlDla5OpZPRdPfExTEy7+7j/0tB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSrMeluC; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e53a91756e5so11219685276.1;
        Tue, 14 Jan 2025 18:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736909124; x=1737513924; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nYM1na8/tUQfjk0eshWOLPcBl/+9IATvuronDd3x2kY=;
        b=NSrMeluCwr5D0wP/6M0C+nGy2SVinj6TjtdF9Wft4eELLluBc9JXaZaKGrLDAy+WIe
         +yG3tJjnTpoZFyT3xldw09iTKz1LKdqO7m/YxWNyIY6+nNPbAjLUDTZDHwA6WTyFmZAU
         IefsdeQfDENuv+5dY9FVlWTgApufq1H0zvNrm+Brv9JscQcpR6ROFYMGcRdQaiyY3KXb
         CUZpKaXpPSfFEHAR/2h+sIHNdgXKvN+yF1DAzhaHJiRsU7SU9fM+T+IhE8p5jCg1xMZn
         z0uMNTJNzdHtMliWiwuBnXExosGtWtq4WcrB4QkBBQ0MYl/pt+oXs3bhaLyJl85XLuhA
         pqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736909124; x=1737513924;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYM1na8/tUQfjk0eshWOLPcBl/+9IATvuronDd3x2kY=;
        b=hQonbObkQkZR9wiRvQkkFQ2erz07HWzkdYEqUWkdlSe8BFdUwSJiGYvgzSmcib6rz/
         qFyj84RaM4mIy8Qm7EsXd4bRYeW/wL6fcsRoj66+MrPa4NCSCtvcAbZil2hvOBCoH22R
         Tv3/bL+kFclEheAdUSgXF8/96nmrqnWR95Wd6LEWH14zswPcCOtX96niL5kktoKFx03q
         EP7Z7L9sHDz6ZVLy3HJu8F1Bg2L9Dvxf9+F9EqEWKMg6CrFjVGah+83pgLaNzj1lXJC0
         l5V7leZY0mt5EwsfnwvbHnSR5nMsJCgjaAJ1ZL0qfvEq4SPYpT2o9gB2i6QeRss7JBWh
         3oZg==
X-Forwarded-Encrypted: i=1; AJvYcCVnTGmhPOvp9xpfYyUPGto0HfwovQddh0IMvoXicaTYr1SKVjNFS3qr0kAJ4QL5dtAJVmAptYpQ/U/OmtUR@vger.kernel.org, AJvYcCW8jZzPZbBrESpQE7zPEPhYCYJlydJJOEuj3/uAbCDvmonSjoOEf6pfsgK7h8R0cZT51pGTU1E/X3Me@vger.kernel.org
X-Gm-Message-State: AOJu0YwCvhwrxOPKOMemyMzzpWCj1aw+bLV7S9Z8DGKk9zRGl8AxXPKv
	FuoJXOkIvoluUsopP8OwyFpOMAcDPa5Bs9THLMxvxpwG688dKTcK
X-Gm-Gg: ASbGnctr/UVlb3pr9PXpJAkeCN6yM4Q6W+8P8ikTjmr4WxfSak+GFN0ATJ3NSjRY51i
	+lXD+dMLNKb+EKoWBAGZTn9Bffi6zmV4+1H/Yu9RCCwPMZ0C5ODNk4y0poVdlkzX04pEhyTJy5u
	+V4lhHlDzeZvH5sHB5HAoXXfRzRQmgvOCVvFjBtl9TIocTDmFmAdkZDMv760u9uZC+TeZq+Z0It
	nfeLG0MaxE4iX9esVaaDHJWFUvneaJ9CNLzvnRwAVmmm1CPiKd7lA==
X-Google-Smtp-Source: AGHT+IG9bhBR/Mlqlxl2kSUTtn0PORJYcxe5mS08dveZp6hKUVWPPD5xZU8ZNQM2Q2l1E+lXHdBO/A==
X-Received: by 2002:a05:690c:6483:b0:6f6:7b02:2568 with SMTP id 00721157ae682-6f67b0227c5mr127428897b3.32.1736909123893;
        Tue, 14 Jan 2025 18:45:23 -0800 (PST)
Received: from alphacentauri ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6b8b21099sm5149107b3.73.2025.01.14.18.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 18:45:23 -0800 (PST)
Date: Tue, 14 Jan 2025 21:45:18 -0500
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Corentin Chary <corentin.chary@gmail.com>, 
	"Luke D. Jones" <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>, 
	Ike Panhc <ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Alexis Belmonte <alexbelm48@gmail.com>, 
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com, 
	ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 15/18] ACPI: platform_profile: Remove
 platform_profile_handler from exported symbols
Message-ID: <dccv6plsmlqd6gabd5aaor4h7wnp6k6nnjudkjfsvzk7tv5yc2@prn3jcmug2xw>
References: <20250114153726.11802-1-kuurtb@gmail.com>
 <20250114153726.11802-16-kuurtb@gmail.com>
 <b271023f-8a84-a48d-2d59-f0815014687b@linux.intel.com>
 <i6wubniwg77joijwqo7jg3q4tv3oit7tehv5uxhgkcnwqukuom@ethn7feuyrah>
 <6a132155-b6a4-b326-5d5e-c9fcc6670265@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a132155-b6a4-b326-5d5e-c9fcc6670265@linux.intel.com>

On Tue, Jan 14, 2025 at 07:55:53PM +0200, Ilpo Järvinen wrote:
> On Tue, 14 Jan 2025, Kurt Borja wrote:
> > On Tue, Jan 14, 2025 at 06:55:34PM +0200, Ilpo Järvinen wrote:
> > > On Tue, 14 Jan 2025, Kurt Borja wrote:
> > > 
> > > > In order to protect the platform_profile_handler from API consumers,
> > > > allocate it in platform_profile_register() and modify it's signature
> > > > accordingly.
> > > > 
> > > > Remove the platform_profile_handler from all consumer drivers and
> > > > replace them with a pointer to the class device, which is
> > > > now returned from platform_profile_register().
> > > > 
> > > > Replace *pprof with a pointer to the class device in the rest of
> > > > exported symbols.
> > > > 
> > > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > > > ---
> 
> > > > -int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
> > > > +struct device *platform_profile_register(struct device *dev, const char *name,
> > > > +					 void *drvdata,
> > > > +					 const struct platform_profile_ops *ops)
> > > >  {
> > > > +	int minor;
> > > >  	int err;
> > > >  
> > > > -	/* Sanity check the profile handler */
> > > > -	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
> > > > -	    !pprof->ops->probe) {
> > > > +	/* Sanity check */
> > > > +	if (!dev || !name || !ops || !ops->profile_get ||
> > > > +	    !ops->profile_set || !ops->probe) {
> > > >  		pr_err("platform_profile: handler is invalid\n");
> > > > -		return -EINVAL;
> > > > +		return ERR_PTR(-EINVAL);
> > > >  	}
> > > >  
> > > > -	err = pprof->ops->probe(drvdata, pprof->choices);
> > > > +	struct platform_profile_handler *pprof __free(kfree) = kzalloc(
> > > > +		sizeof(*pprof), GFP_KERNEL);
> > > > +	if (!pprof)
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	err = ops->probe(drvdata, pprof->choices);
> > > >  	if (err < 0)
> > > > -		return err;
> > > > +		return ERR_PTR(err);
> > > >  
> > > >  	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
> > > >  		pr_err("platform_profile: no available profiles\n");
> > > > -		return -EINVAL;
> > > > +		return ERR_PTR(-EINVAL);
> > > >  	}
> > > >  
> > > >  	guard(mutex)(&profile_lock);
> > > >  
> > > >  	/* create class interface for individual handler */
> > > > -	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
> > > > -	if (pprof->minor < 0)
> > > > -		return pprof->minor;
> > > > +	minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
> > > > +	if (minor < 0)
> > > > +		return ERR_PTR(minor);
> > > >  
> > > > +	pprof->name = name;
> > > > +	pprof->ops = ops;
> > > > +	pprof->minor = minor;
> > > >  	pprof->class_dev.class = &platform_profile_class;
> > > > -	pprof->class_dev.parent = pprof->dev;
> > > > +	pprof->class_dev.parent = dev;
> > > >  	dev_set_drvdata(&pprof->class_dev, drvdata);
> > > >  	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
> > > >  	err = device_register(&pprof->class_dev);
> > > >  	if (err) {
> > > > -		put_device(&pprof->class_dev);
> > > > +		put_device(&no_free_ptr(pprof)->class_dev);
> > > >  		goto cleanup_ida;
> > > >  	}
> > > >  
> > > > @@ -504,20 +524,21 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
> > > >  	if (err)
> > > >  		goto cleanup_cur;
> > > >  
> > > > -	return 0;
> > > > +	return &no_free_ptr(pprof)->class_dev;
> > > >  
> > > >  cleanup_cur:
> > > > -	device_unregister(&pprof->class_dev);
> > > > +	device_unregister(&no_free_ptr(pprof)->class_dev);
> > > 
> > > I don't like how this is architected.
> > > 
> > > IMO, no_free_ptr() should not appear on error/rollback paths. The pointer 
> > > is going to be freed despite the code just told it's not going to be 
> > > freed, which sends conflicting signals. Obviously, it is because this 
> > > function has relinquished its ownership of the pointer but as is it seems 
> > > a dangerous/confusing pattern.
> > 
> > Makes sense.
> > 
> > Quick fix would be to replace `goto cleanup_cur` with
> > 
> > 	device_unregister(&no_free_ptr(pprof)->class_dev);
> > 	goto cleanup_ida;
> > 
> > and add a comment about ownership. Similar to the put_device() call
> > above. Is this ok? If not I will think of a better way of writing this.
> 
> I think it would still be on the error path which is undesirable. While a 
> comment would make it understandable, it would be more logical to call 
> no_free_ptr() near device_register() which is when the ownership 
> gets transferred.
> 
> The trouble with that approach then is that no_free_ptr(pprof) will set 
> the pprof to NULL because of how the internal cleanup magic prevents 
> automatic freeing of pprof (Don't ask me how I know about that trap :-D).

:')

> 
> I suppose you could take pointer of the pprof->class_dev into a local 
> variable before making the device_register() call since that is all you 
> need after that point?
> 
> So my suggestion is along the lines of:
> 
> 	/* device_register() takes the ownership of the pointer */
> 	class_dev = &no_free_ptr(pprof)->class_dev;
> 	err = device_register(class_dev);
> 	...

Yes, this makes a lot of sense. I will do it this way.

Thanks Ilpo.

~ Kurt

> 	
> 
> > > >  cleanup_ida:
> > > > -	ida_free(&platform_profile_ida, pprof->minor);
> > > > +	ida_free(&platform_profile_ida, minor);
> > > >  
> > > > -	return err;
> > > > +	return ERR_PTR(err);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(platform_profile_register);
> 
> --
>  i.
> 


