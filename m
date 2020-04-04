Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1058E19E6E5
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Apr 2020 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDDRvA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Apr 2020 13:51:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34396 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgDDRvA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2020 13:51:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id m2so10902895otr.1;
        Sat, 04 Apr 2020 10:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y95rECaQ8JB4IMFJRuAfYH3Qk60HSfmhEkxfieQ/dWg=;
        b=l4eADaJJP50tnMxSIRVwn/ducog3dlch4SMXXXBsaNnU4CxbudhlHhi0yXdAjfhGk7
         1HH3WXqq55Huz9Kv5ozHX9Oo/+Dnd9hyd/OdAyiTl7LF35BnMOoqU1aMsZHqvnvS5jmT
         gDt8MMaf7cCOWKK03ek3oRWyWM+BemBewqMtSHX/9hqeJqMEeoDHY6FHGQIZhXeG6aZ+
         yaGzl14vElYELcrIHPu/2ZSYVkKy0IeVgWnGOlWeCtd78Wwg7MVuNkYkWtCvHosYiEqd
         bBhKtyi1/ZG/cHgAQTNoDYX7zbWpW2sYWxb/iVWH0t94rHIQsIBFBpcqQ0gjg8gzfdD4
         klrQ==
X-Gm-Message-State: AGi0PuZER9iMjk6dZ9DDOJ2ZPXrxDlv0ZJlW2eyHTSbUqPDBwWa3A9n1
        ZvQdG+o8+EVGllBZauzV5253l4YBMX9YNn44/es=
X-Google-Smtp-Source: APiQypJXXSKrtbFEwdda3esGGDETkJrOSOvYCy5M8vLD2IXdxdKJ69CPDhiUNzeJjGIdiud49pm4phv+b+5KqB034Yg=
X-Received: by 2002:a9d:7402:: with SMTP id n2mr11522707otk.262.1586022660147;
 Sat, 04 Apr 2020 10:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200403140345.3828-1-cai@lca.pw> <CAJZ5v0jjZzSosFwR3Yqu9mWtUNms1u9fbJbQb=tc5=CPc7r_1w@mail.gmail.com>
 <20200403165305.GF20218@zn.tnic>
In-Reply-To: <20200403165305.GF20218@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 4 Apr 2020 19:50:48 +0200
Message-ID: <CAJZ5v0hZH0LU9NeTkjRqzXyMoU8YWn7gpvO4vJQqYDaHAW3ixA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/acpi: fix a deadlock with cpu hotplug
To:     Borislav Petkov <bp@alien8.de>, Qian Cai <cai@lca.pw>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 3, 2020 at 6:53 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Apr 03, 2020 at 05:45:10PM +0200, Rafael J. Wysocki wrote:
> > I can take this one unless there are objections or concerns.
>
> Please do - I did trigger that yesterday again.
>
> Tested-by: Borislav Petkov <bp@suse.de>

OK, applied now, thanks!
