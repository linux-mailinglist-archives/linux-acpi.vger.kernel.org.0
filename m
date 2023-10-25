Return-Path: <linux-acpi+bounces-960-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B48F7D6BF7
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D5C2810B8
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AA511730
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A81CF95
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 12:24:51 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6473C9C;
	Wed, 25 Oct 2023 05:24:50 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b2d9a9c824so1254854b6e.0;
        Wed, 25 Oct 2023 05:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698236689; x=1698841489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqrOjLRs28riw/P20lQEQPNQZ15w1j+cN1KPKpYivnA=;
        b=pyjgYoSsuTFksCGcLkOrD3TI+ID4Hp87AFiVvjcrAZ6xdHUNQ6VHVw1l7HpTrvN0vk
         AXgSsOxYqttU5yMB45637/86/cwKKNwKdaOA4Lna0uZtNaT+QYjUAi7H0omklqiJFoZ8
         g4l1jQKdDBMO0rM9ftFubGKtjYQ01pmvSQ8mi+KyfIJ7hqrhANSJP1Qvs0jpvd35ng1l
         qE201nYiH501Lk4rVHMd8vxLErnXslxEN0uU+5Gtm0O6EPSCVvMlfZX6BPOwZlPXb9Er
         ZbH+JCBNG46USIozBR9nUFk7a9UoFUOYUNszXP+JmxozT/oi+UUrPoHb6B2LyfzASZ7M
         HbFA==
X-Gm-Message-State: AOJu0YwcvUThHcItNrzXcB7IOFk4wdZaVUZvK/7ez6zoXuC213RCJHGP
	mkV1qnolF7t9MU2SIhU3qhyHD7tvlHcs0tZT2ps=
X-Google-Smtp-Source: AGHT+IH0abo2IUeh3MMH/ljYPbwfAcLVEOc9S12Py6b46kJ2D0FQnzYE6dwOuGyQPuXQTVW3E358Eq8mZL3ePrf5tJk=
X-Received: by 2002:a05:6808:2190:b0:3b2:f3c3:3874 with SMTP id
 be16-20020a056808219000b003b2f3c33874mr16080958oib.4.1698236689574; Wed, 25
 Oct 2023 05:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-5-vincent.guittot@linaro.org> <20231025115456.GD31201@noisy.programming.kicks-ass.net>
 <20231025121143.GA28289@noisy.programming.kicks-ass.net>
In-Reply-To: <20231025121143.GA28289@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Oct 2023 14:24:38 +0200
Message-ID: <CAJZ5v0hrsC0TPUt8a+1Fqy7RQqsTQpA3K0H2z0twx4Ya6Apa9A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] energy_model: use a fixed reference frequency
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, sudeep.holla@arm.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, 
	lukasz.luba@arm.com, ionela.voinescu@arm.com, pierre.gondois@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	conor.dooley@microchip.com, suagrfillet@gmail.com, ajones@ventanamicro.com, 
	lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 2:11=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Oct 25, 2023 at 01:54:56PM +0200, Peter Zijlstra wrote:
>
> Also, can we pretty please not cross-post to moderated lists, that's
> rude.
>
> Rafael, can you please mark this acpica-devel crap as moderated in
> MAINTAINERS so that it can be auto-magically excluded from receiving
> mail?

I'm actually not sure why it is moderated.  I'll see if that can be changed=
.

