Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEE62B16F6
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 09:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKMIKS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 03:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMIKS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2020 03:10:18 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AD8C0613D1;
        Fri, 13 Nov 2020 00:10:18 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id i193so7952336yba.1;
        Fri, 13 Nov 2020 00:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZly4fKiBbV+IkexCkfhDwIO10bCLlCQxITCXC1nduc=;
        b=u2+i4ApZzbglKW/ZY0KZq8G55eme853Hcxfb0QmEAFmaNROCNYHDJThV7bgI1Dwj3u
         pR4MtaMYZlMIYkydd2bglPivi43m+c8nhXkNAfWFgNQmT0H/+PCw5y28wYogFlNrJxYP
         xDLcbVmRUclmos/AgE3Cgf5RM3Hz9Yc845piAFhG6PJAfESlmYVU3+TkGWtU0ioNA6op
         Y+6TM93BD96hywl2I7jyC3DpFGFoliP51bZWBPHP1GViSl/X7HmwBEpBuvdvMexUA5CP
         ZWqR1JG3CZDn7H339C32yqa4S/Z2gVJNZq56jaUtMtGMwmq5Aw+rDaX2z4FJXOSSu7ud
         CgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZly4fKiBbV+IkexCkfhDwIO10bCLlCQxITCXC1nduc=;
        b=b2VZjdfF+OCRbzc9J9WuFzeoYiKHpvbnet93iEWZ3iVfGJNCJ/zOV+kRa2GArcAGVS
         Rnr57zLWKNR03UFmQl+DahmrnJtAiDRFvxjL/nFbh+CrK4TC7KW3rimG8n/KtOY2bpvJ
         R20b54vG0YG+szxn4LESQ75IsaLf+1Gr9fNOLlx3N37CCroGA5p/8TfraE6+J6LXxCMM
         xQz0ukmnXYmBkgzu6m/ihgVaOVYH5zD6J4SygQ0CfNXGiGASwWdMlD6D04A+ElAHJOZH
         mQvt/8Vi0L4aubgiI2uuMbGhu9ZbaqZI6o55wd+dN1ofMuULMA94cpedo7KjyXdU2F9v
         /xhw==
X-Gm-Message-State: AOAM533pcrNqYeX8y9Wq7uDkFj5ce/1eRKk9PK/ahMYPdaaXcXQgMj/P
        qb4XSt3ntoACEEsDeAsu6qJVpdYdZ1laM0mxzMKXBBxzQh0=
X-Google-Smtp-Source: ABdhPJwjEpoizRa9L79ZPsT2OVUutT8ozRSyE/0JHG/Ved9tIK9IL3j4WF2zqwupgavLD15Kp/RVtgEi3TpOGmdfEks=
X-Received: by 2002:a25:5f0f:: with SMTP id t15mr1252894ybb.26.1605255017552;
 Fri, 13 Nov 2020 00:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20201111021131.822867-1-ndesaulniers@google.com>
 <BYAPR11MB3256E0C1DCB4F01D18DF709F87E80@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdk2U5+DcXYyMoBAhyaa67EukhB6QMEUbRPcOF7P3Sz21w@mail.gmail.com>
 <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com> <BYAPR11MB3256BEF30840D4AB440A359C87E70@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3256BEF30840D4AB440A359C87E70@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 13 Nov 2020 09:10:06 +0100
Message-ID: <CANiq72nL5O30-QXh9nBnE8rUdkHs=OxZJ=9uVWtKJ3YTDFr-fg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 10:49 PM Moore, Robert <robert.moore@intel.com> wrote:
>
> 1>c:\acpica\source\components\utilities\utdelete.c(270): warning C4013: '__attribute__' undefined; assuming extern returning int
> 1>c:\acpica\source\components\utilities\utdelete.c(270): error C2065: '__fallthrough__': undeclared identifier
> 1>c:\acpica\source\components\utilities\utdelete.c(272): error C2143: syntax error: missing ';' before 'case'

Can you share a minimized sample with the `cl` version and command-line options?

Cheers,
Miguel
