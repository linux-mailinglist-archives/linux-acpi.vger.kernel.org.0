Return-Path: <linux-acpi+bounces-14390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD137ADB2EE
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 16:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E804188E1F4
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB06E8488;
	Mon, 16 Jun 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFZ+690x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A191B6CE3
	for <linux-acpi@vger.kernel.org>; Mon, 16 Jun 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082580; cv=none; b=mvzZvqxaXMEuhHp6aKTDSS3uXf+mmd5WxhpPFU9FotNfL9GWW+Xj9RpLc90rmwtj/tmQaI7URtfdfI6fwE2I13D1xRcFFA3IHQxk96x0HZ2Q17ctpGTliLkJSj4LhGHqU9f2a+yXawpQQKWiYjhnQP1L40aRpDGRlXhoCus4CIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082580; c=relaxed/simple;
	bh=M9iPmr/hd9Ggp7c2g4TZVex3t2dAViOX8F17mzyQZUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzFrn/8vUyHLD5B2uB9M/UFAgcbscfvNttwACXp6SiVKQxt/TqPLTVGqQiRQnmJLr4ZnYZpb7WRq9ZtWHTzwvfHU/n74nzYEwSjbCn/0lYXidGNFZ6b5Ho+rkK77jhttYZ61sfbS70NpsGDdg2xDoqE9xRkm8L5V0kyRhQ1Igrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFZ+690x; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so39478075e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jun 2025 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750082577; x=1750687377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeI7dVZjAypUtlg/sBYp2OboqNhum0d3l9RmKtS5z54=;
        b=OFZ+690xO8e75zEjQ9lx11obZZuDySOcgsDON/tI6jaWQ16389cCqtP9wxbPqwwyyE
         djHlCncrxq/IdzDlTWPuBBze6zO90Nwouo4xCgt7rvczmi4Z3NBHQpH4ZBxdgJ+yZ36H
         t2gyIKWzcCdgm/Nv1sixD4k8k1HV8fMGH9WWj5obMhvrLtr9k5JYEOOjfICilN5NBYUs
         GDYZWNYCls7qr1GfqwNRioYJKqObsmawGQDSLhzlT7R48CDOMXEbJV+0zPWKQreS730J
         Z+TTuWkQ+yYjt+1MVFcuK8+ZGQgBTNcPxSKCL6JI1iP+8Jv7KOEs92spFnDjxOCIUwf+
         hgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082577; x=1750687377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeI7dVZjAypUtlg/sBYp2OboqNhum0d3l9RmKtS5z54=;
        b=BXXXGWe4Y7pIztJlHsLXfQ/oQAK9/kKAZnPT6GTin+1xayzfINbkVPRIGc9YKqnrtA
         7dcF+mPg2obpUi/YX1ptplNYgBxuagPg0e1CMCXU1lTXPCOvx0EX2SXGXbyd7Vj7DZx1
         9cU9Ri1VEEHd6xuR7BPHMwIGlStk1MX1f1wCo6iMLx3Asddtqoorko1B9uzHDpfdndDI
         XYKqOidHrTbZVl4GMklVC/o+QdLS66ZJ5qavCsVRtbcMdy1w4MEbDExRULmXqOxwS6EG
         YvPK1kPjabYbqK8mDMUmtH31C1aTvKcjK5vVJWSOF33ZvdLtsPG630h2SvO/C60VJIzj
         vdwA==
X-Forwarded-Encrypted: i=1; AJvYcCW774oIGjKVVDCRnlNFAZWKSA0F2zIfiqkxm96Z/+PGpRY6V3vcWKuLiOrd5Kbi9egMZWKWFxOzEQCL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlqz37d3dS/wwdsQccJFhN66gTG1ZTwWLiOEo3oiVaAIwg+Rb0
	Rjxz/dxNbArZQoJp8MV8kk74N6Ly4XCqD4k+e8JDSCOvBTQA/0MzNCehT0ev9tDvOzT57kfEu5c
	CyRyFUl9ZJn2EX6bv1LZf1FRCaF4doteqpDz+pZ/5
X-Gm-Gg: ASbGncuEtNX/a60UClf9nhaR0YSZBUER8+lw03hBnxDsCwKfAfpLNE/twcisjU9WXSc
	g+0rBmhrJXLpNrwoUbuRjTDmxrq5viAz5BXN5wt10jP82bABBc1IU9RbGNJGlx0L8l5iOSfR0g6
	pB+lKZYD1TsaRDSXFXwFWhC/XgyBBsFA0Kers0dsuIcIAr
X-Google-Smtp-Source: AGHT+IG6mhibxRmrcpXyyVWbs6Zi/EB3mKvbkPCAzyyW7ZMRYgcWpCLi07Oq9F9r3b2+3Uf4STjRbMPp9QJZxFXkpB4=
X-Received: by 2002:a05:6000:4203:b0:3a3:6cb6:defa with SMTP id
 ffacd0b85a97d-3a5723ae1b5mr7662579f8f.40.1750082572895; Mon, 16 Jun 2025
 07:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025061313-theater-surrender-944c@gregkh> <20250614105037.1441029-1-ojeda@kernel.org>
 <2025061446-wriggle-modulator-f7f3@gregkh> <a3a08e5d-bfea-4569-8d13-ed0a42d81b2a@linux.intel.com>
 <2025061546-exile-baggage-c231@gregkh>
In-Reply-To: <2025061546-exile-baggage-c231@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 16 Jun 2025 16:02:41 +0200
X-Gm-Features: AX0GCFsVDhmmW3g26qu_6PoP9y5f0Lj5YfUuf6wjtzXOaEVtlzvaf6PEfRuyuhc
Message-ID: <CAH5fLgg2aPtnWDqoZ8wi1OGge4PBB_Y0LSM9TSviowquEQXCVw@mail.gmail.com>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in faux_device_destroy()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Marc Herbert <marc.herbert@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Benjamin.Cheatham@amd.com, Jonathan.Cameron@huawei.com, dakr@kernel.org, 
	dan.j.williams@intel.com, linux-acpi@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, sudeep.holla@arm.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 5:36=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Jun 14, 2025 at 07:53:34AM -0700, Marc Herbert wrote:
> > > the kernel relies on this not being "optimized away" by the compiler
> > > in many places.
> >
> > I think "undefined behavior" is the more general topic, more important
> > than null pointer checks specifically?
>
> Is this really "undefined behaviour"?  There are a lot of things that
> the kernel requires for a compiler to be able to build it, and this is
> one of those things, it can't do this type of "optimization" and expect
> the output to actually work properly.

My understanding is that -fno-delete-null-pointer-checks changes the
language semantics so that nullptr deref isn't UB anymore and instead
becomes a guaranteed crash.

Alice

