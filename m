Return-Path: <linux-acpi+bounces-13840-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35A9ABFA01
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 17:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224328C4333
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0023214225;
	Wed, 21 May 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3WGDN1Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB81804A;
	Wed, 21 May 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841855; cv=none; b=dTx7ARlQ0DKFLtO4oGBt0lJ3o2jtU0hf7wStE4NCovFSWLSQ5T2HzCO04Bgqal6Jx3yE0IzIVcjpgw4d1/mv7/sc8gI3XCM4gh58D3N1tJZxoBRzsjo5ySNPVDec6WNVrM9fpeMpMXRLhH/7wgoPA+c5d7v5X4eKI0Mk4DMmVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841855; c=relaxed/simple;
	bh=ADK/Td3RDt99ZV4Od+lvJYGkKDEJfqfUeq/jiR79XOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nka8/AkFZcT+fXOxktZBPeLJ/hhnpMstidthA2VrztpMWTJGDjl6Mj1JMIOrKJzXDGopG5vudOZhUfHtwAK7IDhYnOadtTFgE+4O0/LKe+5IzrhGZwhAx32cDspakOxvLMos28x9YmB9/rZqmkbQa1LDY6Ua5ZCCisBlQsB0SZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3WGDN1Y; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7053f85f059so59814387b3.2;
        Wed, 21 May 2025 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747841853; x=1748446653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXz9lx51WkGfQh0LsBFFBo4w6d+gyQqxpGMLfxBRNqY=;
        b=i3WGDN1YgnSNpGmlDOxVz26GCOzKot1bEI33sacV/B09WwTthwQZfzpdwQ59XURqbk
         sJ6IRjuVxjU8iaPuMiGHt4m01BYi7H6FSM+HsVLVEzUHWtH9BysMkzfGW90meuji1dPB
         t9pv79Hc5F99OjcgU4hKEezKlEbm/kcjbzP8wB2KaCYM4l3WlztDOWqx7DPtd5Bq4qss
         8h3A0AlbJXLh2KiPuPji8pc31aE1MTQxF/82doQf69h59XhXdCdJHWTTDlEtbXIQr9M7
         GHBWD1y+6fg+p+LaOu0sbmRswYhGJKp0odl8RBXT8hNJdsnhL9bIa0WVE4SbVzs8mQMc
         +SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747841853; x=1748446653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXz9lx51WkGfQh0LsBFFBo4w6d+gyQqxpGMLfxBRNqY=;
        b=NWAUkAuZYLrsxJtlmSQj3lTwEGMwxXdcEMJU8cV+hRtI1thXq8MfNcZjh87ZGeHx7D
         aFMa4IsdJrxVmA3EU0/9LnxTzZGOujtockzAxeCHPdAdGzLaesiCxZF6a7o52qo2Lwhl
         lz4wQrcV2WAltCXbAXP4yIeG10ClzY79uaQ5/fHEpLy5cqDi5dR3mKN5QQR7HwbiGaKK
         O0y9aNBdPYcYlkpFy0c8/ZOcBLMiiaJFBLBt8SyJCobVMZEoXEs7udeazeBUXWhhErsb
         /Mv1EuLa81HNmIVSd9IBsMZ4Sbr6sJG9Yv623Dz/Zu54ukCpaH0cqsy3421YYAnMl+Pg
         m/2g==
X-Forwarded-Encrypted: i=1; AJvYcCW91OXHi05v8dKjR/fas01BFYIbjyytWMNeRocirHM0UGKBXD8v1jEChKaFsEdWBSex/he+TmAv3EI8t5+3@vger.kernel.org, AJvYcCXrsfY4E8tDB70miIvARhghbGNus1CHdRNVBY0oEMKBz9TwfgGQnXwoDF2KG6QBnomvv7n0/Iav5rRZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6fRjLV8dxpYM4j0HTwXUClPOY9wF81USpRyik52pou2igvUbh
	xibgDKeyCdqFXOQZs40c2mJkztvIURaHlkxT03s1YCK05N+QSVkeJwjP
X-Gm-Gg: ASbGnctA8co55cvZ2WClMpUQkF9wf+L3lUmSCWVyHhEJVvU95rvZDFcA8lDY18r9qxx
	KzU0rRoPB++FMmIgM6ApV9u5crH3RmDpU7stGYUfVt12s9GPXA7vcHgUlV2CKSjlryCBp47ujdb
	TCQBKEK+ofzWgNlfUErYhUWMxvx98oAiIMSY0yzdIU+TjZYK+sIfHomI+R/AFnx42sB9huX86QT
	4BTXdSx0zgm7CbiRyMNupOU2GP+tuU86kHQWL2T/Z1GPeqEQPm0f1wxD9wdrfsusgL2kXG5Q2RF
	WeeDCT0TDKDliyV/x4b8sPxO20RBNqWydrjyLwTLpHrH5nVO2W8=
X-Google-Smtp-Source: AGHT+IHcTIpbOksovtOKwx3AWf8/MFLrvERSTWegMnFdec2dXutO1vy/yF+FCzS5NzXtLN5i0iqqNg==
X-Received: by 2002:a05:690c:450e:b0:70d:f15d:b18f with SMTP id 00721157ae682-70df15db251mr50542587b3.26.1747841852839;
        Wed, 21 May 2025 08:37:32 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70ca852dee4sm26808817b3.113.2025.05.21.08.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 08:37:32 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: gourry@gourry.net,
	akpm@linux-foundation.org,
	harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
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
Subject: Re: [PATCH v9] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Wed, 21 May 2025 08:37:29 -0700
Message-ID: <20250521153730.2196701-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <25283dbd-2867-4034-bb16-951e0fb81843@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 21 May 2025 15:04:00 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 20.05.25 16:12, Joshua Hahn wrote:

[...snip...]
 
> [...]
> 
> > -static void iw_table_free(void)
> > +static void wi_state_free(void)
> >   {
> > -	u8 *old;
> > +	struct weighted_interleave_state *old_wi_state;
> >   
> > -	mutex_lock(&iw_table_lock);
> > -	old = rcu_dereference_protected(iw_table,
> > -					lockdep_is_held(&iw_table_lock));
> > -	rcu_assign_pointer(iw_table, NULL);
> > -	mutex_unlock(&iw_table_lock);
> > +	mutex_lock(&wi_state_lock);
> > +
> > +	old_wi_state = rcu_dereference_protected(wi_state,
> > +			lockdep_is_held(&wi_state_lock));
> > +	if (!old_wi_state) {
> > +		mutex_unlock(&wi_state_lock);
> > +		goto out;
> > +	}
> >   
> > +	rcu_assign_pointer(wi_state, NULL);
> > +	mutex_unlock(&wi_state_lock);
> 
> Just one nit: if written as:
> 
> ...
> rcu_assign_pointer(wi_state, NULL);
> mutex_unlock(&wi_state_lock);
> 
> old_wi_state = ...
> if (old_wi_state) {
> 	synchronize_rcu();
> 	kfree(old_wi_state);
> }
> kfree(&wi_group->wi_kobj);
> 
> You can easily avoid the goto.

Ah I see, thank you for the suggestion!
I think we would have to move the "old_wi_state = ..." to be inside
the lock and before the rcu_assign_pointer since wi_state will be
NULL at that point if we do not, but other than that, I think this
is a great optimization over the version I have : -)

I will send in a fix patch for this later as a cleanup patch, if
that sounds good with you!

> >   	synchronize_rcu();
> > -	kfree(old);
> > +	kfree(old_wi_state);
> > +out:
> > +	kfree(&wi_group->wi_kobj);
> >   }
> 
> I'll note that this rather unrelated churn (renaming functions + 
> variables) is a bit abd for review as it adds noise. Having that as part 
> of a cleanup patch might have been better.

I see, thank you for your feedback.
I thought it might be necessary for this series, since I embedded the
iw_table inside the wi_struct, so we can no longer just free the table,
we would have to free the entire wi_state it was embedded in. I apologize if
this was difficult to review -- I agree that this patch was on the longer
side. I will do a better job of isolating parts of the patch in the future.

> Nothing else jumped at me (did not an in-depth review of the logic)
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thank you for your Ack, David! I hope you have a great day!! : -)
Joshua

> -- 
> Cheers,
> 
> David / dhildenb

