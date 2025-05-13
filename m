Return-Path: <linux-acpi+bounces-13702-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABEEAB569B
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 15:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA86467B42
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA2298CCF;
	Tue, 13 May 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQVxzcsW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4D1F12F4;
	Tue, 13 May 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144780; cv=none; b=ZygPLdxSIVYRW/3RS5hfnHdzkLQUDPwXMQwAMQM+5imOw1Cr17sxrGkKnZCCsls8grrXM2gU+yp4wBy9Pf8HB1JJaAW8wwvf6nZE1RP6XIiDbklG2DoLxOCJAfHywewPZF7OelU3oG8Vw/UTT5S/zJSf6VhxiIEW+xwqY1otfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144780; c=relaxed/simple;
	bh=uupRQJKR5302NtGuYUnRSSAUi44AgE1Gm0o6msWcW54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=momB2cRB4eFUbd+ZNu/7HhOK82SJ7rtKTyScSNRzijY7/K+h6SJocdOxfwiTs5jCKbaWq7kubsFv3tycpPQ+vS3/20IydSkj/FCEb271RXEsgNNv1fu1TDeRVklFJQ+NRV9nc7FGop5Grm1+1jONxrVYSR5CzWeDQZiZMwD6bfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQVxzcsW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70b50e0566fso25429867b3.0;
        Tue, 13 May 2025 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747144778; x=1747749578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxHPphgXbWdm5nbT9IaJtyapq7Mq0HF46NjBnfggMmc=;
        b=aQVxzcsWeancnsXzEFNkeQcnqThDgfAIqaqcGJweX64pa3RazRtGfZmWdLohxzR/SC
         /Ik5k6V6CQxVFkxCvIqnZExmaWemKyG3iMXHHv02b+6G5eO/jfvTMqkeOM7Tk1+uLHS7
         /ypCVMB/NgcS7O86BrUuFO1Lhmm+ofrp7r9pvJKGc/zjEJ2Q41fMv3IXraEmvKDO68zU
         OIZD3onw9g78VMWTbG7XDg58s5huWh11+yk7hhRx1VBvsLBuz9b7Fdw0HGXSSyQafL7q
         F1tqHCImadsC+r8dO3WLiV8zawZocT6aopXNRNnRQhpS2qJeipKGLMX2ApsHSAU753LN
         eAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144778; x=1747749578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxHPphgXbWdm5nbT9IaJtyapq7Mq0HF46NjBnfggMmc=;
        b=a+YuTVDKRAAHF3h+9uwJ0yjxD1dZWvg4KkUB9rFnUs7Nun/yS1ZfmePf1+UF+3pc7W
         95XVU2ISfW5m9QylfSS2AaAhJLKFrnavd7rRNv+QQf1d2GhBrOn06ngxkP7PSKxrJzwb
         8d4hsOldSPN1cDw2YnI9ok4+uWqegwJE0rlhdsAGI3jDlybWeDRVv1bd4BEj/7KzoKnf
         rU0/2TDJGui6e0+vURausN+/21oGGmSJAba3E61W6Y8OjjjgAWqXcbRAjvCmGZ+hdSfQ
         tKh1Iqhq1JrwbkqePsAxR+q0VwiXBl4bNLonWzshz0o8txUC0/wDwYYB/Rb7urmN+TAc
         XlJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXil74GqI7ygzQjkC2RvFn1oVYR2Jw7vdkRx8LiUsXPpvPisn5owLj5RXxUPy/9IIcpVNK+WOO7Ccg61/76@vger.kernel.org, AJvYcCXvZta5YZJRZHnAGaE6oBk26vpQSnJOmLm6zQO0BDSGSA/ZpBoJMJ4JUggjhtWSZpq3cQgnavlUaHEr@vger.kernel.org
X-Gm-Message-State: AOJu0YxU31lKt8REOYG9n8uh6uf3XGg39Qw+WHIk3aYAAxtbdqCjPXdu
	PfDkdN+kEhLSjMx25G+/HEl6NXDZfbkOIH58yA15IyQIA1VWNwm3WSPDvg==
X-Gm-Gg: ASbGncsPL1Apxd9Kd8uMvvDpgUdbOOFBz07PIkP7ENoS9sId95oxRQWklv7gaQtviki
	C5abwTZ/+dybXpAtZlq7QdCupmtPl6tfuKl5i6sMb/C4xoYuTT86SNuUk0/0fRuo4CWtBlkr9dh
	nXgP0VQEhTYOrAeHkZT5oMXHmJ2TK2Z8jfHBXE2nfPbg2mHPnZDraQts/sFMy5Ad7LW4ZsOP4Dn
	eFEI2/UX7+fGKZWCXsqehfCxtWzxJc730HxDBy4Vpvms98X6ypI+7jCLNgCRldFPlztqx/Psw93
	tCUICrtF8lftbtQB/9N/AZK3sErK69JkOUzW4f/2OYgTf2yQKy4=
X-Google-Smtp-Source: AGHT+IHHNeRb5OLaGj6qAjtuql5TdNI/3gNeh0Ot5Zvdx+MoysAHOVc6WPZPIR8ztl4F1Alzh3G7ZA==
X-Received: by 2002:a05:690c:4d08:b0:702:52fb:4629 with SMTP id 00721157ae682-70a3fb123ccmr221926307b3.23.1747144777713;
        Tue, 13 May 2025 06:59:37 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a3d9eccd9sm24474957b3.97.2025.05.13.06.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 06:59:37 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	gourry@gourry.net,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	osalvador@suse.de,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Tue, 13 May 2025 06:59:33 -0700
Message-ID: <20250513135935.2914896-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <87tt5puw21.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 May 2025 09:41:10 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > On Mon, 12 May 2025 09:35:16 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
> >
> >> Hi, Joshua,
> >> 
> >> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> >> 
> >> [snip]
> >> 
> >> > @@ -3707,8 +3720,12 @@ static void wi_state_free(void)
> >> >  	kfree(&wi_group->wi_kobj);
> >> >  }
> >> >
> >> > +static struct kobj_attribute wi_auto_attr =
> >> > +	__ATTR(auto, 0664, weighted_interleave_auto_show,
> >> > +			   weighted_interleave_auto_store);
> >> > +
> >> >  static void wi_cleanup(void) {
> >> > -	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
> >> > +	sysfs_remove_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
> >> 
> >> If we use wi_auto_attr directly here, we can remove auto_kobj_attr field
> >> from struct sysfs_wi_group?
> >
> > Hi Ying, thank you for this comment. I should have caught it as well.
> > Removing the last users / setters doesn't seem complicated.
> >
> > Andrew, I'm very sorry -- do you think you can fold this fixlet in as well?
> > This is a minor change that removes the only users of this variable.
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index d5ae36d2eda8..8581cc861945 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -3543,7 +3543,6 @@ struct iw_node_attr {
> >  struct sysfs_wi_group {
> >         struct kobject wi_kobj;
> >         struct mutex kobj_lock;
> > -       struct kobj_attribute auto_kobj_attr;
> >         struct iw_node_attr *nattrs[];
> >  };
> >
> > @@ -3833,7 +3832,6 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
> >         err = sysfs_create_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
> >         if (err)
> >                 goto err_put_kobj;
> > -       wi_group->auto_kobj_attr = wi_auto_attr
> >
> >         for_each_online_node(nid) {
> >                 if (!node_state(nid, N_MEMORY))
> >
> > Thank you both, I hope you have a great day!
> 
> Thanks!  LGTM, please feel free to add my
> 
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

Thank you Ying, really appreciate all of your feedback throughout this
series. I hope you have a great day!
Joshua

> 
> ---
> Best Regards,
> Huang, Ying

