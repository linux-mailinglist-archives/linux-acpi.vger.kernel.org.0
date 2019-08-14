Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40618DC9A
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 20:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfHNSCq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 14:02:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32769 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHNSCq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 14:02:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so114043otl.0
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GKs5FPWymwQ5gbNZtdTdyRE1Nom6j8+Rxk1X5Ak3ho=;
        b=ux5jbquFlU00xiYhyCHomWd5e32yEqg48ZmXd5Kocjz5nhLaYh6WxI9VNlnCNfdxXe
         Yiip9K8vSXkS/iwxJk5PeIQ1aniVfrXPti8aC2lM/bykilrlvCUl16CRS2nKiJhmNlmh
         CWonW6QNpGzk7nOcd7UR0Zb/ewa6RGZ1S5JFj73exIoBaDEtPZ4R9pSNe4S0BxWBKsYn
         2RqAWQFosegu+aSrRCE5Gt3tAK/jb5qTIhRDF7Ty0EJ3W3EBXWcmX5wuXfXeGMsShLre
         lP9LQKbLCYB17G8cXA7Sgq7qyhzp8TnBxoz+XJ5SDnfoOqDCUh8upgGBhxaqLxoMixrj
         XN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GKs5FPWymwQ5gbNZtdTdyRE1Nom6j8+Rxk1X5Ak3ho=;
        b=PA7HstiytWFO7lkmQpCcNdbQEi5ehsTavNOSaipdXIjor+f9iPwjdU8FTfuZp5E2YY
         SF84Pd9TZt6jsTvSdbCtDNROBbZyCC2GvkcpIX7O1qb40179yi39zGQrcaKc0RBvmugR
         jBIW1O76T6ZMQVRs08RRpaLnlfMM+kzKKXRegJB1jJMiN5+YgvfVw2YwBC97Laf804hO
         MmRRnj93P7o5+jikqWGucA+PMMc+rIFWK7w6H6y8Y6FwDzO6cmh5WsMYkl604puIBiwY
         mjFT/vI9PHZoBDZBquphZ9ICQbDS8aULmzFiR04M5M12lH4V2M2JZQjTfph05BwjHO07
         TYRA==
X-Gm-Message-State: APjAAAXeMPG8Gm84TRobRgsN26Q2JzDFX2HWLq4/gV8x/0Gmt9/Fo2Bn
        48PnYGtXFEpmpXhS2KfXAG0rLRBCrimwhe2z4KFuyw==
X-Google-Smtp-Source: APXvYqzmpHudrjVFaOAaYw4VS7cZnHmFbCJw0EyJVqf5FRTM6F8GCZmq3Mx8zMllZGVFxW/G3bIOgn3IkDXpEgvjxPc=
X-Received: by 2002:a5e:9404:: with SMTP id q4mr1266718ioj.46.1565805764794;
 Wed, 14 Aug 2019 11:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
 <20190808000721.124691-16-matthewgarrett@google.com> <20190814072602.GA27836@zn.tnic>
 <CACdnJuuOhuw71GDwQOrPQxUexpvpZNJocr6m0dYzJw+MMaVKWQ@mail.gmail.com> <20190814174732.GD1841@zn.tnic>
In-Reply-To: <20190814174732.GD1841@zn.tnic>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 14 Aug 2019 11:02:32 -0700
Message-ID: <CACdnJutcF6ZdQKwz7L+i9FUuD8SBsHuhk8rwQpwfDsCpM1y9dA@mail.gmail.com>
Subject: Re: [PATCH V38 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 14, 2019 at 10:46 AM Borislav Petkov <bp@alien8.de> wrote:
> Yeah, ok, I see what you're doing there. AFAICT, you do that in
>
> setup_arch->acpi_boot_table_init-> ... -> acpi_os_get_root_pointer()

Right.

> I hope nothing needs it earlier because then we'll have to restructure
> again...

Passing the RSDP via command line is a pretty grotesque hack - we
should just set up boot params in kexec_file, which would leave this
as a problem for legacy kexec and nothing else.
