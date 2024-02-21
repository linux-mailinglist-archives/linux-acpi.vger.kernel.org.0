Return-Path: <linux-acpi+bounces-3758-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4100985CD27
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 01:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721801C22967
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 00:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041F17D5;
	Wed, 21 Feb 2024 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWOT7l0O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F57187F
	for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476792; cv=none; b=hTNkeINQBwr6dWsWWFfLbzyoygwBJt1a5ZIkPhNnhyytRdnCpWhyGZjnn6zNSvs0Tb/SEDfFtwqCIk81pg94eO+GEDMJg/rkcxwggFuRWv37XbkfEkHHOndMhY5rmbzFHE9Jpf8URW6YGi9q3rkf4pJCcQYqjH5y+2YuXYGLiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476792; c=relaxed/simple;
	bh=hd0lhH+wZU4zitJitsjtcio44xa5sDrhwLIhJx54M48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNW8x+6g9kpFumMQlQNOFkKY2qhAJ5JEKWudZX1UfxLrYXdFMAx1vl//z7vlbOf7fQSQKnpCOJC/tboGorBk1TOQfKaaoMa6iBD6Sw2vjl8NHBu8h6Z1GdNAwSPvObccmgFl9sa5tmln6AFx+EzJGuWjA+ZXWLmy1aSvzKqr2Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWOT7l0O; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-428405a0205so86741cf.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Feb 2024 16:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708476789; x=1709081589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3aliKXEbglyQXiBZG3IVeVy5el2cZXqVD0gVl1TNUU=;
        b=kWOT7l0OVNXQJZGbA0M2wa8mXmNF1FzbDVMSzI8aBoJlPp8DAsoPt5ay+l9NA0qIDN
         ST85QDVzD2RnqQnK2kkylX5HySvD6oj+ys2U/pPzHCih2jwfFd5OjD41xjMTlPTSY0Gd
         vtmDD8G+imhgluv4ZRtdPo/F2xG8rbhPOAoWM4Gi37eNTscCafk2/N5devtB7AS2b1cr
         hKOCsm+VcJKUN3+owsqWk4/PYWJ5npvYrkA1/14SQknr72D43w1VsbmKGwK29j337cHx
         8tjup32fJy0MOEowzOcRrMJalOoULQCoqeyBB2qjueWfVSLLmrjjEyNfaUfSAn9vVfaN
         rhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476789; x=1709081589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3aliKXEbglyQXiBZG3IVeVy5el2cZXqVD0gVl1TNUU=;
        b=PbzYjj3KXQvEhnbkZccF2KiU4Ty2ZKbZBp0mLWmYB9qV0dPcwmNspImcOqSvtasC/D
         HT/6VCbq0/kjKIRubnt079PIiQsDR2Ld17Wwo/fCBkVgPvAX4asrnsIwAxLpGuGs1rrP
         JgBQrh6XDMLbDJEyFnQzm3U9tgQsigzDZnvPb6pDqqlbi4b4GQUGopiy1BPBBrb4wDdf
         C3GKuukyttlZDATQynI9ZKAucEUZUAGEiKThb14T1xpJH3rraZ/BA357UIQWprazXRU1
         zjixWwOMyM+xVG25+fCWLcEKmg2Fua5IKreumziRoEI3VK+vXtzUxpVpx9gfbpwz5mjB
         pOzQ==
X-Gm-Message-State: AOJu0Yx/CyXuHjlX/BhcnxVkQbo6RQ2xIaDMf1l6QbL23rUYqTxIaiXL
	0dk2K5OLmDFf7uxEJkY0y3wO55LSIL5cWYCXIca/2zxVYkrZQ8QdDuD/L8HrIqrefjiAsS/xxIw
	Lw8mH0vwaGbY+C5AJZOUBPnDmUdjGUdhl13rE
X-Google-Smtp-Source: AGHT+IGuojBOIL3NwHNGp1txCVvfo0pbzvMxcixAlnHZkwYRAeUSF6WVNWbxiaJVoKHnLXQs66Ob2cvkY1Z84vxB6qY=
X-Received: by 2002:ac8:7c47:0:b0:42e:36fe:df90 with SMTP id
 o7-20020ac87c47000000b0042e36fedf90mr46324qtv.1.1708476789278; Tue, 20 Feb
 2024 16:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220175333.3242277-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240220175333.3242277-1-andriy.shevchenko@linux.intel.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 16:52:31 -0800
Message-ID: <CAGETcx8w8YhC89JOYkQgcXrZgqfXOUXHXq5+86OdHGSfqz0D=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] driver core: Drop unneeded 'extern' keyword in fwnode.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 9:53=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We do not use 'extern' keyword with functions. Remove the last one
> mistakenly added to fwnode.h.
>
> Fixes: 19d0f5f6bff8 ("driver core: Add fw_devlink.strict kernel param")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Saravana Kannan <saravanak@google.com>

> ---
> v2: fixed a couple of typos in the Subject
>  include/linux/fwnode.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 2a72f55d26eb..2d23a14857c7 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -209,9 +209,9 @@ static inline void fwnode_dev_initialized(struct fwno=
de_handle *fwnode,
>                 fwnode->flags &=3D ~FWNODE_FLAG_INITIALIZED;
>  }
>
> -extern bool fw_devlink_is_strict(void);
>  int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup=
);
>  void fwnode_links_purge(struct fwnode_handle *fwnode);
>  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
> +bool fw_devlink_is_strict(void);
>
>  #endif
> --
> 2.43.0.rc1.1.gbec44491f096
>

