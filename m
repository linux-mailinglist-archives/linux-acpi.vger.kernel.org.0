Return-Path: <linux-acpi+bounces-20110-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DBDD08DAA
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 12:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBEA4300C284
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D433358BD;
	Fri,  9 Jan 2026 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA16CyRP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA852F83AC
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957485; cv=none; b=ACzbg/nGxQghlFX8K529IpMGzb7CJVridxBkS80BpMh7VW6Lip5cpzyjMV/3tPwGPa/OtcC28O2XPAb0187u3AWq8qVBbOAhoFEh4Fe1gFoGpkLdwhdXopDgpemJUfkjNa9DpWdnA4Ze982bJnnr09QukrzF5g2kYAnT6lGblaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957485; c=relaxed/simple;
	bh=X8/WMKVstLlblwrlkCF982nlFs5kTORZzTZM70moIEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jdlo9F2EslGBphEObyjvNBfYAXvmTJxcFlBQh4TrTTqwgkvfvEvK5DJeMFndjlkdfotLOlDhW+daGm1HTv4v1sRER68a9OaJOZ7PUwm3/yJQaLKwWDifJEDZo8Job6LunibG7nGBvx/duQguJwLcJyz0PFtJPdhaG1sGnCUO7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA16CyRP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso2214991a91.3
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 03:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767957483; x=1768562283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjUDjcQuilw8JIwts0suK0wZjsghxEmkzGbdS7ChzGE=;
        b=QA16CyRP7H/Wlry6MfMuzr71lxJBipC+VLGDnAFTFJDz0knTauZoKZka5CE+021wbc
         66AkzZWQNJNe+rNQgA4A64bMch85eDpdJYSyXW/Fe4dpuq2jTdNrrUI4jKFesP1Bm8Vc
         7oJaOr8WCmUGvd+oNqUaCYiIZ2PjggHuknvXUMcuZhLVi27+iWHLPdSe9a4t8NistLWP
         Ma9k+EKfiM4i7CL28nLQ6WdhOIiDq5dr4solqjUr6btS7bjZb8Pfev9A/ALhIN/HJrgp
         NcGOmDJwdjIntHQ4uZlDhL3ze6nhXAAh+/KnjkjJ+/recf2KQ/Yhd38RoQ0oVx6dQdJj
         T8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767957483; x=1768562283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjUDjcQuilw8JIwts0suK0wZjsghxEmkzGbdS7ChzGE=;
        b=EUOJ6hJ0kN3OxjjepZ+u5UL9c1SaLodihUCjnW4i55ukWkVJpDwgaXN0GIPW92M1te
         mlL2ZHh5ghKyVxCYO0cZzRo7FvUMB+DVZ3fEHlqUOI3nrnLzi6ienoXRwXd6hGSQjM4V
         0yYET/YJNhscixfCTB3QN1Le/4j3C67zEA2rZaMsEignPfkIKyQvlaVmErmftmWm5GSr
         pruT0QmtHVF0bTev/91reE2jn0WerAWs24NHsB6nytH8GM7n4ZXttskegW0s0Mro4YY5
         o9uL5+e0ZPCuEUGF60WBrHx0O62kHY+s7N70inspEI+kw1Ii0fgwOVeHj6eGJcumFsdE
         HaWw==
X-Forwarded-Encrypted: i=1; AJvYcCUGx0ZUhdkWgnJa5wApTYzw5IsimFtXl0u4Sr/VUxdz3DXE0kXJDsn7/ZOU8M8FBiyApqWRqNFEWlC6@vger.kernel.org
X-Gm-Message-State: AOJu0YynIMs+VNIq00aLVJ5GPMGJp2awhK5V8NFVZo0vrv8xsoVMtLtr
	G7WeDlkqYZ6jLK9PNB7yp0I6RvVDvi8SGwezPJtCu1bW7YJSLV8MVsWZFIDfkGbqaklZpp37bUE
	NCps7KtcR2jgTBwl5ZoHBe+Q/MFDdsIvmQm0+xu4BfA==
X-Gm-Gg: AY/fxX52r7AotC6jlbhrTBpgPX6HzF8+Hj+4SelD4Sh5ihUh+qMcHM4qXYAyANdHQTV
	JGh4s0sYYYJY4Xk1UgOXAJfnj+Hoy6Xu0HvLMRprQgpH0vJXXFtkpJoaTe4ZaDymPfqCpWKpC93
	RUExHFsO0/LI2lu2qYH+ZI0wIwB0TFaR+yWjUw0y+AIbQVWEQbJcrTpbdlw5UNdGDLwFdhK3OOo
	XUDw0hTF/yQVKaTR2axH8rxJfhJsPYxU1cGJbv5bS6feXgGf5m5BjuHPZdaCiFhZ+ImyPUwstO0
	qHTO13XKMcagy5Y8unC0WRcfJIk=
X-Google-Smtp-Source: AGHT+IHx4oPTkZGWjnk/fIhFxWXX8VfQz8sfZRQ1a4hPiuCQQJTajebNqbmfM9bRR6L7VucF04h2carmFdn7uSAQrXw=
X-Received: by 2002:a17:90b:5846:b0:32e:a8b7:e9c with SMTP id
 98e67ed59e1d1-34f68c28180mr7896138a91.29.1767957483181; Fri, 09 Jan 2026
 03:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767818037.git.foxido@foxido.dev> <a119094f2e248587c541daf7c5b65bf4398b281b.1767818037.git.foxido@foxido.dev>
 <CAKBF=psGUwgr7e+EM1d2OAv8H1A6zKfhQaSPS56vVcnc=Ez_KA@mail.gmail.com> <622213c0-1793-4b1f-ba9a-aa99f73047f6@foxido.dev>
In-Reply-To: <622213c0-1793-4b1f-ba9a-aa99f73047f6@foxido.dev>
From: Kari Argillander <kari.argillander@gmail.com>
Date: Fri, 9 Jan 2026 13:17:47 +0200
X-Gm-Features: AQt7F2rayWG0pZpVs1FxNxeC6wOj6LoY8YXn2LOhC92JjlEG-eQdaJfa_fOGPrk
Message-ID: <CAC=eVgQNvsGWSbnm=V6V=S-gQ75kiw7=JPwOsaTDKQPwoXqEAw@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: add WMI abstractions
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

pe 9.1.2026 klo 13.12 Gladyshev Ilya (foxido@foxido.dev) kirjoitti:
>
> On 1/8/26 22:48, Kari Argillander wrote:
> > On Wed, 7 Jan 2026 at 22:56, Gladyshev Ilya <foxido@foxido.dev> wrote:
> [snip]
> >> +    /// WMI device notify.
> >> +    ///
> >> +    /// Called when new WMI event received from bounded device.
> >> +    fn notify(self: Pin<&Self>, _dev: &Device<device::Core>, _event: Option<&AcpiObject>) {
> >
> > This should be device::Bound
> >
> > Also probably _ marks are not needed. I think compiler does give
> > unused build warnings.
> >
> > I do not know reason but usually other drivers use this over self. And
> > device first so this
> > would be:
> >
> >      fn notify(dev: &Device<device::Bound>, this: Pin<&Self>, event:
> > Option<&AcpiObject>) {
> >
> > Same also in unbind. But like I said I'm not completely sure about this.
>
> I thought the reason for using this instead of self was because of the
> limited set of possible self types in previous versions of Rust...

Nice. Didn't know this. Thanks.

> IMO using Rust's self is more readable

Agreed.

> >> +        build_error!(VTABLE_DEFAULT_ERROR);
> >> +    }
> >> +
> >> +    /// WMI driver remove.
> >> +    fn unbind(self: Pin<&Self>, _dev: &Device<device::Core>) {
> >> +        build_error!(VTABLE_DEFAULT_ERROR);
> >> +    }
> >
> > unbind should not be mandatory so here just do
> It's not mandatory, that why there is default implementation. See
> https://rust.docs.kernel.org/macros/attr.vtable.html
>
>
> For other comments: Ack, thanks!

