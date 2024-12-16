Return-Path: <linux-acpi+bounces-10147-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC759F34E2
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 16:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C1F7A0302
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8041386BF;
	Mon, 16 Dec 2024 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKQP1xrD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8549845C1C;
	Mon, 16 Dec 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364011; cv=none; b=I8/eJaS+G3rnLQqrEJVSma8kqeCmFUZxJ5urTOkkyGDJNHR3Vu2qcEGEGiq1E8R9y37oYA3xIPiCPJbzoPRvKo3BwzgT4D9wso+bTzvRbIU3U/MdL9riVyZ+0raRUsw9vyU/xRtXffQ0ID24JThYssH2KaMeX5+ZizaN8d9+lPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364011; c=relaxed/simple;
	bh=52p+YxtohD7VXL8b1WzYoec2dWIHx5VGUb3oMtcwsAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXtFK1PLngn8WCm+mnprQ5G1NJIQm7c5qTdCUBOeDEbPWKWdwR2qeC/1LC2GQE5eoYzqcjpsGege42jqJMlh/Zcpgmvld/9HFqEX7RmT2tvhryOWUPQ9F+uK6DyC5v/BP+ScW0OJOvoYH+3yVkcXc4mpEvCejNZc/lJm7U8qmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKQP1xrD; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3c8f39cab1so3293104276.0;
        Mon, 16 Dec 2024 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734364008; x=1734968808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/L24M77KEHgjRD2S/cq3ONFt+aksrwaxpiJzcqZqpE=;
        b=kKQP1xrDRDmNY19J2ypW1pCPeLN7FwsVISs9cGhNU2Ln6XTaaYOdcXsVqAe8JEVcbM
         07auoS1z+qV9AW9MHkD1Sqy9fpULPuMj0cZt+q7Xp+7Uhi/pXAk+ULIcRr89/tR55DX8
         8/leKGVojz/lZ16E34e8GFTDmyq5LpLI3Sdhcp7ZgUa2xV30dj4S26mr+UpZcX1gkBe7
         d/8XEBJKag0WVdU8fmiD0S6VvoKFXmu8kaN3NH5p4AuSk5zrhUpGUjrNhfvGREPFxgUH
         /wcWAlnw2C1qd8REOQb3iqhTREVTVsUSRO91hH/2Sb5Ba4vbKAEwQtdWIcCGulaLEeO3
         zjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734364008; x=1734968808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/L24M77KEHgjRD2S/cq3ONFt+aksrwaxpiJzcqZqpE=;
        b=cCw21Qlg8/RLL5mRSm77DbXf9G7XUJGufN22j6FfVE/Ls3dBXX9TfUy8ElXZRcfnRU
         JgBRpNWYxCNdW6+WeUBuLJHqf+2oBGyPFdKNTRCKiK7EdHeeBE4T0IBbDEgExlSBKREX
         qaVpEeXTUWs9CQWO2/qjAqvgHBU+7vopdC+u+sXnUM8RKB02SHJzDrxM0sZkvQkuXBiX
         dbbhWiG/3SQKZuDCPn3M8cfxM2CGKY7CmOlk4/e6Eh6n5SzVjWKsl3ipx+5p1zvRAD3v
         0eNM5AsgQcgk3869fQPOEz0fFhK66bXNMKhZeG/QnI4PQk7csDe1tFQraimlFbptYrui
         z3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgq+HyG5rm9HEkVV2snJFWGsUT3jePg6t8JC3lQR/gcjdnQ9Ni8brlVXD8J1p85gUWY2vR6L34kT+LJjgC@vger.kernel.org, AJvYcCWMAb8miOJKtM0jhBGjbI2ZB1MPRMbOm77UX0PKl/lLztvv7sFoBTdhJisvUOHhOU1l8XLHdIk7ycwa@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuWOzomSNrW/VqWTAZIy6Y+Ryl1/GfWdCl05RwkA/sHI5ALY+
	WTsTM+F56yn184pLquk2Ex7LatSeOr40IHZ3rq22OWevNYnJ3wd1
X-Gm-Gg: ASbGncvS43FML2Kphk6ZvhdGUw5H+L9T15z3i5vNRNv+1Q/R09jCcm3Ggq5V6kNXP8s
	sKivgpVsPtq7wR+x0/SfuzoPosA1WXJ06mqtH8ud/ur0pthAKUmNgbM3OVUBgmc6tfUmnmuKXVy
	GbHnFKmGVTGP9WCKLEhiOwe1Hq8Fh+CcyWOKU4jvRK0hQNnHipxBvw6nJV7aL3vMHW+YDjgFIuh
	J4aigf+vKj/j1t+PnRTXNxFqiHNMeT0CVpGa6+V93RMGNVVNgVd2XdhMNhOnNAaNHwqTNnKgmZW
	dxn0EqMuJ+GsCn7NDA==
X-Google-Smtp-Source: AGHT+IE03JmeV99mfjBTG2bTimbuUBUR2MDJ2a7PMRUxwdPG69gs36EkqipuHIrHqvnQVAvu+4KPpQ==
X-Received: by 2002:a25:86cf:0:b0:e38:259e:bddb with SMTP id 3f1490d57ef6-e41ecf8143emr11678223276.11.1734364008390;
        Mon, 16 Dec 2024 07:46:48 -0800 (PST)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e470e54d912sm1404678276.60.2024.12.16.07.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:46:47 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: hyeonggon.yoo@sk.com
Cc: kernel_team@skhynix.com,
	42.hyeyoo@gmail.com,
	"gourry@gourry.net" <gourry@gourry.net>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	=?UTF-8?q?=EA=B9=80=ED=99=8D=EA=B7=9C=20System=20SW?= <honggyu.kim@sk.com>,
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
	=?UTF-8?q?=EA=B9=80=EB=9D=BD=EA=B8=B0=20System=20SW?= <rakie.kim@sk.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horen.chuang@linux.dev" <horen.chuang@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: Re: [External Mail] [RFC PATCH] mm/mempolicy: Weighted interleave auto-tuning
Date: Mon, 16 Dec 2024 07:46:31 -0800
Message-ID: <20241216154646.1499268-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <7ed89f33-6ba0-44c7-b4ea-0c72029fa33b@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 16 Dec 2024 16:53:47 +0900 Hyeonggon Yoo <hyeonggon.yoo@sk.com> wrote:
> 
> On 2024-12-14 4:57 AM, Joshua Hahn wrote:
> > On Fri, 13 Dec 2024 15:19:20 +0900 Hyeonggon Yoo <hyeonggon.yoo@sk.com> wrote:
> > 
> >> On 2024-12-11 06:54 AM, Joshua Hahn wrote:

[-----8<-----]

> > Hi Hyeonggon,
> > 
> > Thank you for reviewing my patch!
> 
> No problem :)
> 
> > As Gregory showed in his reply, I think it would be possible to get host bandwidth information
> > using the ACPI HMAT.
> 
> You're right. I was wrong. I checked on our server, and its bandwidth 
> information was valid for both local memory and CXL memory. Sorry for
> the noise.

No worries, thank you for verifying from your end as well!

> > [-----8<-----]
> > 
> >>> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/max_node_weight
> >>> +Date:		December 2024
> >>> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> >>> +Description:	Weight limiting / scaling interface
> >>> +
> >>> +		The maximum interleave weight for a memory node. When it is
> >>> +		updated, any previous changes to interleave weights (i.e. via
> >>> +		the nodeN sysfs interfaces) are ignored, and new weights are
> >>> +		calculated using ACPI-reported bandwidths and scaled.
> >>> +
> >>
> >> At first this paragraph sounded like "previously stored weights are
> >> discarded after setting max_node_weight", but I think you mean
> >> "User can override the default values, but defaults values are
> >> calculated regardless of the values set by the user". Right?
> > 
> > In the implementation, the first way you interpreted is the correct
> > description. That is, if a user manually changes a ndoe weight,
> > then updates the max_node_weight, the previous manual change will
> > be overwritten by the newly scaled values.
>  >
> > Does this behavior make sense?
> 
> Ok. then current implementation overwrites the node weights
> previously set by the user.
> 
> I think it makes sense to re-scale all nodes and overwrite manually set 
> node weights, because it's what the knob is meant to do, and the user 
> still can override the weight by setting node weight after updating
> max_node_weight.

Thank you for your feedback. There is a slight concern, however, where there
is a semantic mismatch between the name "max_node_weight" and its value.
Like the description suggests, it is possible for individual nodes to have
weights greater than the "max node weight".

However, the alternative would be to re-scale all weights whenever an
individual node's weight is manually overwritten to be greater than
the max, which I think makes even less sense since users probably don't
expect changing one weight to influence other nodes as well.
 
> By the way, could you please explain which part of this patch implements
> this rule? IIUC it does not invalidate iw_table after updating these
> default values, which makes get_il_weight() to use manully set node 
> weights even after updating max_node_weight. (Or probably I just
> misunderstood the code?)

Ah, I am sorry for this mistake. It seems like I didn't update the
actual iw table, updating the default instead. Thank you for the catch,
this will be updated in the v2.

Actually, there are a few more changes that I would like to make in the
v2, the biggest of which is to lay down the intended behavior more
explicitly in the documentation so that there is no ambiguity
from the user perspective, and make sure that the code actually
does reflect the intention as well. 

> > Have a great day!
> 
> Have a great day too :)
> 
> --
> Hyeonggon

Thank you again for your feedback, happy holidays!

Joshua

