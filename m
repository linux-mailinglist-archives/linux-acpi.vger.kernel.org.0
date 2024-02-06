Return-Path: <linux-acpi+bounces-3248-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBC784B193
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 10:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1BCB212C6
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8631912D745;
	Tue,  6 Feb 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2Kpo4au"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601912D15F
	for <linux-acpi@vger.kernel.org>; Tue,  6 Feb 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212923; cv=none; b=X4vudnoe31AqWFnJ6t3lVllwM0nvygvuJD9BqMBpT5ItKmMc8+uuQBko0LqocjAcUryCabtIc3ENHRzEy9dVJF7l5mApano3JAN6DDnifcV+gjFqxyNpss33GkTEFNn6w8+zLLeqQsbPRFHL7zupGtQfGPdVTMwlxXXqS0n6Js8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212923; c=relaxed/simple;
	bh=ZECXte5D6jxim+3xK4HKfAtIsgXPnPOa+pKdouz7m2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPPzi95PhBCZHO3iDysSpjoHJE1CsQdwTo4c6MMD9QV4eVKHUb65qz6PFVu8P+r0prb1Y0BxhAyiOnOKxPx46Iv0FlbB3xaeCJfKQrCIuLD7GEDRlAORH/OQFrnR1HOZCRUlAUuAEmTq7rEkHjAp5Oh5QcBXZ4jHjyQmq3MTuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2Kpo4au; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707212920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZECXte5D6jxim+3xK4HKfAtIsgXPnPOa+pKdouz7m2A=;
	b=h2Kpo4au8g19SBUWo3a8Cx5lJg6nR1Lh8rSG51SzWkcH+1O1+lR1nyGFoSxBt4m9vtV3QP
	Kg5aYpyHnrNpMy/c57SJbBdD6CLppMH2y+OAL0+PpRl61/oT+4eA8Zh0MclHuO57A9c6gP
	DlyPVIrtAhrxvhls6tH6QUp8Jzm6M5U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-KVwrqE7UP7eksedGkzGflw-1; Tue, 06 Feb 2024 04:48:39 -0500
X-MC-Unique: KVwrqE7UP7eksedGkzGflw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7816bea8d28so71322685a.0
        for <linux-acpi@vger.kernel.org>; Tue, 06 Feb 2024 01:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212919; x=1707817719;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZECXte5D6jxim+3xK4HKfAtIsgXPnPOa+pKdouz7m2A=;
        b=rA0vVjTCZ/uW2RGIRut7o5kktLDbyg9LwfdfmDopPa5soq3944jomdYqN2pLnxdA//
         7BPLxJ97YqJ2eRgL3LTKjtObVieCnX633T2bvCxpMS8itCxgvSNJgy4TeROJ1suQfeMc
         j64ZH98VGCXHQ3zC6TdMf5n+GmpzrTvQlfxAUTe0DhiiCyV91lIX2agV5GgtmGViEFR1
         p2pJwkr2hNX+X+xNQvYsA0+wghkcKebFl5NH663gZcz6TrLV7G7AaFwwAYdWTlk4CB31
         AQroG1n34NnvXP0qSlXCvYHQeFgYJOHziqknc8y5lDjm1aWMoNSi+TjVwtPLo+oAhGSh
         58Zw==
X-Gm-Message-State: AOJu0Yw03pdX2Zt8wTr4d11Yz4w5h+dp5qYfXcoT75Cxqeccqii/hro3
	MEFB9mnwM5Q23P2IBi49V4DPlAMj8KRU8TU23ASfp+rZ8G81gMVG5iSw3r+lht7WJ6pW47QBXcu
	+MOSE79F9T938EcsmaEnz0WyuiJApEYCwxb2H78/ponCQ2MOtRZaDPRs03OU=
X-Received: by 2002:a05:620a:a0a:b0:785:440c:88d9 with SMTP id i10-20020a05620a0a0a00b00785440c88d9mr3132316qka.26.1707212919012;
        Tue, 06 Feb 2024 01:48:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVZHwKbOSJItUHx/ikHRtM9wqEPD3H5+QvbQpwtzXtmamlTFpTYFt3g/syo8NgZPxdcW1S0Q==
X-Received: by 2002:a05:620a:a0a:b0:785:440c:88d9 with SMTP id i10-20020a05620a0a0a00b00785440c88d9mr3132299qka.26.1707212918799;
        Tue, 06 Feb 2024 01:48:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWrwQH0hQVhe0VPR2hZe1xCBNzOga+tBypyXg9hbQvH1pSJTdI7ZgtdHVcgn6rRQl+DcDxogftvodzYEPMJcaE1n9N7qNBFDS0DzHuY5qac4HvBPl4xY1ZKtO+OG4//zVUqXI6pu9szxT6PbFd+Mg3/Q9NK+yt1QHl673JhfVjN68a+gsIW7JBv8B72s99yHahQdNhMJQCacc10tltod0G851RTWM9eydTsNB65V+244gDRPrxEs38kkuQhc6VsRrfWU8+x+p2KzxN+bFCXjenbh5UvaUgCP/k6wcRaVPZrJmqidM9WzpAXS3w4drJCjsCrAcyPeFlYA3KX3DIPbbrQYBfaanGCJ0r+tQvk66smv+0XgnTtph+0swz1geuaMIoW0VbyW6unIY58owxDU/xoismXsKre7CN8N+hBbz5NFQwr1kx4d9KCg+tBBCw9KWPXRf+Msue1u9Zrurx3kdKYb5j5P+NtCZ28MKScxPbx7tshK/gRorlyHgmpvKz39Q2Wr9OKV7QbVqKcQsTDAwFBNc6/VzBZYuROo9rQkomBdVIQMrxdgleexKu8XRwurJTaACHsWiMlbACtt6c7Aqv5VstSx/I8wnE6bQ==
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id vr11-20020a05620a55ab00b007815c25b32bsm764188qkn.35.2024.02.06.01.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:48:38 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Onkarnarth <onkarnath.1@samsung.com>, rafael@kernel.org,
 lenb@kernel.org, bhelgaas@google.com, viresh.kumar@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 r.thapliyal@samsung.com, maninder1.s@samsung.com, Onkarnath
 <onkarnath.1@samsung.com>
Subject: Re: [PATCH 2/2] kernel: sched: print errors with %pe for better
 readability of logs
In-Reply-To: <20240206051120.4173475-2-onkarnath.1@samsung.com>
References: <20240206051120.4173475-1-onkarnath.1@samsung.com>
 <CGME20240206051402epcas5p2ae3737fc0d71ba1d7a7f8bee90438ff2@epcas5p2.samsung.com>
 <20240206051120.4173475-2-onkarnath.1@samsung.com>
Date: Tue, 06 Feb 2024 10:48:33 +0100
Message-ID: <xhsmhh6ilhqj2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/02/24 10:41, Onkarnarth wrote:
> From: Onkarnath <onkarnath.1@samsung.com>
>
> instead of printing errros as a number(%ld), it's better to print in string
> format for better readability of logs.
>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>

I quick ripgrep tells me this is the only culprit in sched, so:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


