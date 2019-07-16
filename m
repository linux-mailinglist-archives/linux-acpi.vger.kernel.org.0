Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD796B07F
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 22:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbfGPUfH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 16:35:07 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33884 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbfGPUfH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 16:35:07 -0400
Received: by mail-vs1-f67.google.com with SMTP id m23so14882343vso.1
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jul 2019 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTXuJjlx5q7Qe80Yz5WGd6e0nqZG+IooCpGI3pnycJ4=;
        b=ciR4v8OhapnxETOGK7wfTSZ2HGLg5se7oSc+10v/R6wCoaTEmXzWxPDt9oxHC7JyTF
         3OBlmd6OF2VFqqBP5UA5gEGCQpxr6VsxRZq+UJyxjUuhV4fZS+fn5gUYNVQmFqwerA+l
         Dvlk44dSQmMS1DBn+qEEaLADi+7J3vPMB+uAkK8S6qGv2j2B01Am1tLxy/G5/Nq7wpwm
         kELdNFdRDu3OT26VIB9t72SodzeeS67ODNGn6uZA/Izb2C5qi3+K0OTAxcOoFrC5DIFb
         OgPkZr/yEBcciExidG+IrFGISg9uEbuuiV24lVUWbVDYx8i1P5Yb4kZVXHWnuaNhCIS+
         4L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTXuJjlx5q7Qe80Yz5WGd6e0nqZG+IooCpGI3pnycJ4=;
        b=Yc1UXGTjFTGTndrrGA3H3G8SkpSICgASteQISfY1/kC+gba5NsnLzgZdRhrZXWChLY
         HpcMJVzIXeQyndsQ4oSQ9Sp2+fMWBH8WTbGAy0RRa8dNn/MT73e7yGWPC2q58g41ZQbi
         BjTeagqCRIyhcjxOV1nB+4XSy4lSC4f9dc6lwgk5Ty8kMimOnupN/5QI+GHCsE2oFEvv
         WbyXcFzKE1bvxJVSUqEawxQ0YRhNJE6uQqd6f9HtVe7n12B84kFNQt3MA/OI9qH2nIth
         GXqIlYerEpTMDJkDZBfhpY9CaBJZDldN3O9o9aM4DTONVDXOIPiVRs2GJSGuB+hE8oCV
         Dosg==
X-Gm-Message-State: APjAAAX7y2Ri8Rq0dhbrBlipDxVWWfiVKqrenskvNo2xnFyWvNvgUVaz
        mE/4hzKLY5N09w5LuIPB5Bvs4CP6K4VA7C+cYaCXMw==
X-Google-Smtp-Source: APXvYqwULruIwhcKPZuWhSs6rndmokQERBpELkF586kigli0sXfpel4ZL/ik7omczmrrcRQVAd0KEsGFYuf4cFnxhF0=
X-Received: by 2002:a67:ff99:: with SMTP id v25mr22116833vsq.158.1563309305642;
 Tue, 16 Jul 2019 13:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
 <20190715195946.223443-16-matthewgarrett@google.com> <20190716025923.GA5793@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190716025923.GA5793@dhcp-128-65.nay.redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 16 Jul 2019 13:34:54 -0700
Message-ID: <CACdnJuut9cfc1fsAy63t0Z=JVujmNELm2Xm1grEZzORF5Cuviw@mail.gmail.com>
Subject: Re: [PATCH V35 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 15, 2019 at 7:59 PM Dave Young <dyoung@redhat.com> wrote:
> I'm very sorry I noticed this late, but have to say this will not work for
> X86 with latest kernel code.

No problem, thank you for catching this! I'll update the patch and
send a new version.
