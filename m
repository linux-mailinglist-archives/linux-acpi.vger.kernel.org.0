Return-Path: <linux-acpi+bounces-9961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862759E5FC9
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558E016C0C5
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46F01BD9E4;
	Thu,  5 Dec 2024 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXw9HduX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101B1B87ED;
	Thu,  5 Dec 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733432264; cv=none; b=cKKbe7/ncRJYZD4XHjarcMyOdlt4Ndu6N0e+lRu/e1kfZReXb34yPQhPM7IiQ7XLE21x+8c/W5M6EQ9c4ewcCWHMl4whxy5YvCedBXtMYFNowoTd358sUaWwldRf5LHqZU/WMTNWAfR98+zXANU5fcq0v30xM8ZVys+cx3orcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733432264; c=relaxed/simple;
	bh=bXSzby0hvnLZ0qv9eLTFsdH85WbSNNxJt7ob8/XBARE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFIhmdf2mYE9lcCenXD+07GPChj1CWCbHvA53KgtznDVkDh4HRRQ/IocU9rwCc2yw4FmI2jiQ9srL7ZFAcEBCg44oGO63d3ZfePfyfcWFIAGHYy8UEhVQD8GQJq2jZnu7Z9TiJbq3qFJPEUV3awvkUfxpF+By9VftxRZuEIbp5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXw9HduX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1103568a12.0;
        Thu, 05 Dec 2024 12:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733432262; x=1734037062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yJYdYsCWZVuGog0Sfct40Fl4Auwk6UGWQUDUoRbidPg=;
        b=PXw9HduXByNlex6OIyPtvBOs5WIC1uMpXLs4NSi7J12vg+HM/AVxIz4EmQzQJZ4W48
         Wck2015GaxQsW9iJK8L9ybi2CUS2myjbrVH2e2CTtIMBKcyQlGnmoUBzbUd+puVEHbsb
         lQ+TLg1lreUTnWgetELf7698xIjoLG3Gk88TmOZtSGTZu1e0y6kGBGzlC5kZy+GtYMjP
         1Z7aUHCT99Rl0xmSz+4vuv6u1I3rbsOFHQcLG7vPC9jvHqr2n6HzpcOiPnrI3qvor5/s
         Y49cdmA8JEMIn6Id3wdlmxtSetHULY3acuEA0u35ukSKUjxh81/0e4Ujm6AnEHkmJ3Ks
         4ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733432262; x=1734037062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJYdYsCWZVuGog0Sfct40Fl4Auwk6UGWQUDUoRbidPg=;
        b=xJrAl5xieIiI7w3xr1PmvuIRN5sQ13AS3Pp+JnJ6Iyzp73UcszLKVyDTumIMuIEOoU
         cWVTMZvE1HGUMfylXxjdgDzJvyw/kTqP6iYGL+sRjZ+O9kAll9ffw4hb5x4h0NrObzrG
         7ym6hBLZ62NurnX6UFWWQ0bL3jj4yPBRKLi3cWuYeYCxFaR/wp+X1y42RQ9Tspw+WLXM
         fy1ZwSoEaB0SP3z68T3JbiaX0UM7x0CePz4qarq2dHtBB/P8RB6yxxnaMlBJ2fVXqpFo
         D6w6ZgU4yxxoHzh3ZkDYNY5VoBIe6HR8t9K+/tSVCDAi5xx7ZNhF0lIOSIcElw/Kt7cJ
         pRBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6SSI24ogvZd8wBHy46+NvvoIZF+FtDu37Dm86cO7GZIaW9bq52nlyibNkKNGuIJRHSp1E5vV+XFsMKK7p@vger.kernel.org, AJvYcCUPJlzUr1Gv9IKIVoc6sLMt93/v22RY+O9fy5k8RVB3du/dqxWbb513hIs43zarIFk37OuPyzOfOXLa@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7UE4SbeIQOSC3odOri0cDYfIC/GKJuzLyzGv0wXhAR4SURg1
	6ZQ+Uef+EESt5Frhal1ttdxv5gCq9819iIOtaUam4pJEltJ12uUh
X-Gm-Gg: ASbGncsLSQMTpam36M6GBoa00loZjneQA9brrn/XmeCQil1oPdPV6RhhipinnTRwa9T
	DV5S67rnepL/wg4lyEf/V6FkXhAYTBvbG4JAyVYABtJqxoZ0vfdk/i1jF05rpKxgbEmmcAFTneP
	HQS5h1BglZkNpdsotfj9s48XtJRw03mqUaz8pmQHZpAhJoUFntOlOZx7ogX3MU5BoocXawGRBvl
	OpN6nTs7v5uf6sxHiZt1lrqzKeiokeJfwzWMBSVOoy+orVDhkc=
X-Google-Smtp-Source: AGHT+IGPQ7lBYi4pYB8s6MjQrrs0QfJIM629bd3og+IERFIGnD8s9P9180sbiXAKiPA/zSe9sVSNrQ==
X-Received: by 2002:a05:6a20:7484:b0:1cf:3c60:b8d3 with SMTP id adf61e73a8af0-1e1870c66f8mr498600637.19.1733432262040;
        Thu, 05 Dec 2024 12:57:42 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:1f09:3974:393a:8d85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2ca62cesm1659382b3a.136.2024.12.05.12.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 12:57:41 -0800 (PST)
Date: Thu, 5 Dec 2024 12:57:38 -0800
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
Message-ID: <Z1ITwpJcwPNc37X_@google.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>
 <Z0j3EtRmYBmGFApu@google.com>
 <Z0nUpytu0GFUgQ9V@smile.fi.intel.com>
 <Z0q75n_P3sZYnviO@google.com>
 <Z0uHJJKMog-REw1D@smile.fi.intel.com>
 <Z06b0oTvxUi4DTlx@google.com>
 <Z08HQ2JmETJLNuud@smile.fi.intel.com>
 <Z0-KHYnhu81ljbDk@google.com>
 <Z0-tcsOw5imlWZn4@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0-tcsOw5imlWZn4@smile.fi.intel.com>

On Wed, Dec 04, 2024 at 03:16:34AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 03, 2024 at 02:45:49PM -0800, Dmitry Torokhov wrote:
> > On Tue, Dec 03, 2024 at 03:27:31PM +0200, Andy Shevchenko wrote:
> > > On Mon, Dec 02, 2024 at 09:49:06PM -0800, Dmitry Torokhov wrote:
> > > > On Sat, Nov 30, 2024 at 11:44:04PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Nov 29, 2024 at 11:16:54PM -0800, Dmitry Torokhov wrote:
> > > > > > On Fri, Nov 29, 2024 at 04:50:15PM +0200, Andy Shevchenko wrote:
> > > > > > > On Thu, Nov 28, 2024 at 03:04:50PM -0800, Dmitry Torokhov wrote:
> > > > > > > > On Thu, Nov 28, 2024 at 03:13:16PM +0200, Andy Shevchenko wrote:
> > > > > > > > > On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:
> 
> ...
> 
> > > > > > > > > > @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> > > > > > > > > >  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > > > > > > >  	struct fwnode_handle *next;
> > > > > > > > > 
> > > > > > > > > > -	if (IS_ERR_OR_NULL(fwnode))
> > > > > > > > > > +	if (IS_ERR_OR_NULL(fwnode)) {
> > > > > > > > > > +		fwnode_handle_put(child);
> > > > > > > > > >  		return NULL;
> > > > > > > > > > +	}
> > > > > > > > > 
> > > > > > > > > >  	/* Try to find a child in primary fwnode */
> > > > > > > > > >  	next = fwnode_get_next_child_node(fwnode, child);
> > > > > > > > > 
> > > > > > > > > So, why not just moving the original check (w/o dropping the reference) here?
> > > > > > > > > Wouldn't it have the same effect w/o explicit call to the fwnode_handle_put()?
> > > > > > > > 
> > > > > > > > Because if you rely on check in fwnode_get_next_child_node() you would
> > > > > > > > not know if it returned NULL because there are no more children or
> > > > > > > > because the node is invalid. In the latter case you can't dereference
> > > > > > > > fwnode->secondary.
> > > > > > > 
> > > > > > > Yes, so, how does it contradict my proposal?
> > > > > > 
> > > > > > I guess I misunderstood your proposal then. Could you please explain it
> > > > > > in more detail?
> > > > > 
> > > > > 
> > > > > Current code (in steps):
> > > > > 	if (IS_ERR_OR_NULL()) check
> > > > > 	trying primary
> > > > > 	trying secondary if previous is NULL
> > > > > 
> > > > > 
> > > > > My proposal
> > > > > 
> > > > > 	trying primary
> > > > > 	return if not NULL
> > > > > 	if (IS_ERR_OR_NULL()) check in its current form (no put op)
> > > > > 	trying secondary
> > > > > 
> > > > > After your first patch IIUC this is possible as trying primary will put child uncoditionally.
> > > > 
> > > > Ah, I see. No, I do not think this is a good idea: it will make the code
> > > > harder to understand for a casual reader: "Why do we check node validity
> > > > only after we used it for the first time?"
> > > 
> > > Theare a re already a few API calls there that are hard to understand, I spent
> > > some time on them to get it through and still got it wrong as this series
> > > shows. So, I don't think we anyhow change this.
> > 
> > The fact that some code is confusing does not mean that we should add
> > more confusing code. We will not fix everything at once, but we can make
> > things better bit by bit.
> > 
> > Look, the check where it is now makes total sense, you added it there
> > yourself! It checks that we are dealing with a valid node and returns
> > early. The intent is very easy to understand and the only thing that is
> > missing is that "put" operation to satisfy the documented behavior.
> > Anything more just makes things more complex for no good reason.
> 
> Right, that's why I think we need to go away from open coding the iteration
> over the list of nodes (primary, secondary, etc).
> 
> > > > For the code not in a hot path there is a lot of value in simplicity.
> > > 
> > > If you really want to go to this rabbit hole, think how we can get rid of
> > > repetitive checks of the secondary or more if any in the future nodes in the
> > > list.
> > > 
> > > So the basic idea is to have this all hidden (to some extent) behind the macro
> > > or alike. In the code it would be something as
> > > 
> > >   for node in primary, secondary, ...
> > >     call the API
> > >     if (okay)
> > > 	return result
> > > 
> > >   return error
> > > 
> > > This will indeed help.
> > 
> > I think this will indeed help if we ever going to have more than primary
> > and secondary nodes. It is also tricky if you want to transition
> > seamlessly between different types of nodes (i.e. you have ACPI primary
> > with OF overlay secondary with swnode as tertiary etc). And you probably
> > want to add support for references between different typesof nodes
> > (i.e. swnode being able to reference OF device node for example).
> > 
> > This kind of rework is however out of scope of what I have time to do at
> > the moment.
> 
> I am not asking you to invest into big rework, the idea is to try to fold the
> iterations to a kind of loop. Is it feasible?

We could potentially do something like below.

BTW, do you know why fwnode_property_get_reference_args() returns
-ENOENT for NULL or error fwnode instead of -EINVAL as the rest of them?
And would you object to unifying this?

Thanks.

-- 
Dmitry

index 0ca3c0908b0c..3b4c394138e2 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -18,6 +18,28 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
+#define FWNODE_ITERATE(n, result, cont_val, op, ...)				\
+({										\
+	int __ret = -EINVAL;							\
+	typeof(result) __r;							\
+										\
+	for (const struct fwnode_handle *__node = n;				\
+	     !IS_ERR_OR_NULL(__node);						\
+	     __node = __node->secondary) {					\
+	        if (!__node->ops || !__node->ops->op) {				\
+			__ret = -ENXIO;						\
+			continue;						\
+		}								\
+		__r = __node->ops->op(__node, ## __VA_ARGS__);			\
+		if (__r != cont_val) {						\
+			result = __r;						\
+			__ret = 0;						\
+			break;							\
+		}								\
+	}									\
+	__ret;									\
+})
+
 struct fwnode_handle *__dev_fwnode(struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
@@ -57,16 +79,14 @@ EXPORT_SYMBOL_GPL(device_property_present);
 bool fwnode_property_present(const struct fwnode_handle *fwnode,
 			     const char *propname)
 {
+	int error;
 	bool ret;
 
-	if (IS_ERR_OR_NULL(fwnode))
+	error = FWNODE_ITERATE(fwnode, ret, false, property_present, propname);
+	if (error)
 		return false;
 
-	ret = fwnode_call_bool_op(fwnode, property_present, propname);
-	if (ret)
-		return ret;
-
-	return fwnode_call_bool_op(fwnode->secondary, property_present, propname);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_present);
 
@@ -259,18 +279,15 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
 					  unsigned int elem_size, void *val,
 					  size_t nval)
 {
+	int error;
 	int ret;
 
-	if (IS_ERR_OR_NULL(fwnode))
-		return -EINVAL;
-
-	ret = fwnode_call_int_op(fwnode, property_read_int_array, propname,
-				 elem_size, val, nval);
-	if (ret != -EINVAL)
-		return ret;
+	error = FWNODE_ITERATE(fwnode, ret, -EINVAL, property_read_int_array,
+			       propname, elem_size, val, nval);
+	if (error)
+		return error;
 
-	return fwnode_call_int_op(fwnode->secondary, property_read_int_array, propname,
-				  elem_size, val, nval);
+	return ret;
 }
 
 /**
@@ -414,18 +431,15 @@ int fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 				      const char *propname, const char **val,
 				      size_t nval)
 {
+	int error;
 	int ret;
 
-	if (IS_ERR_OR_NULL(fwnode))
-		return -EINVAL;
-
-	ret = fwnode_call_int_op(fwnode, property_read_string_array, propname,
-				 val, nval);
-	if (ret != -EINVAL)
-		return ret;
+	error = FWNODE_ITERATE(fwnode, ret, -EINVAL, property_read_string_array,
+			       propname, val, nval);
+	if (error)
+		return error;
 
-	return fwnode_call_int_op(fwnode->secondary, property_read_string_array, propname,
-				  val, nval);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
 

