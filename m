Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FE228F2A
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2019 04:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbfEXChL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 May 2019 22:37:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43524 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfEXChL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 May 2019 22:37:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so4348516pfa.10;
        Thu, 23 May 2019 19:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VkIHxooMNHFA9OLZaAiTW2cThVgCM7r7P1MhM8qIu0w=;
        b=qA07P64oWp4ssWXss0N7gOa09mR05BfmjwpoL8tSeaKLrgwqzDn8K1cTuj3YQvBGfz
         515UA7eNgGYE6o/iJXi5PiK4vdARUDGa4FAXqVTlnt2G5u7aCNEitd1w+qx2rlpY5hw4
         NMMf96D22RY20ivghoPIdD0YZnvSlobm00RS4TIiht9AjxSYHklzxTECb3u6i+7OGHAI
         bIFqR3aPsXOOj45Djnq34UbIC0uzaUh9E5CVv7P7okI0FSt2ZHO4Epp/rOynjKK8Lrzo
         NZdflIFh4NvuASfCgR7uzX22mtYJF/1uuDkMCOV/nzGESnm7ouhTdXcaK5XzGiXShO20
         YkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VkIHxooMNHFA9OLZaAiTW2cThVgCM7r7P1MhM8qIu0w=;
        b=fmD3R8KMVO0gYr1VMeqansWoJDmRvG1B+7bvrq/82ZC0HVz7Poqk4vO0Sni3w1xop2
         OPYwmZH8UGBSQfezW7couwvfxaY/z8BORa2vqyU0aMz33j6pwMojReYlkTYOmgF6AnfK
         7uwAQgHxc2jCyomo8Q8EoVbquhiFYvMkroGcqiS5eXGTKl8YPhsliFM3iuM7PrmSigqj
         8fhVBzErMqNzxl1D3m8yewaiYE7a3cbDYSHjIPa5dQ4/gwshar7jpSvcwAFYQe9g+BdM
         WcTHCNJPnVpGjtld4S8gf0OB/aZwMEs4DKmVG397C7U1sns/hBf/dCC6zsKgDRp64mpv
         LTQA==
X-Gm-Message-State: APjAAAVseU9uHGZbf9SF8xIDvuuOQpOz5xmnc06HE8fu7wnKAhdRjRXE
        LTaYoZdbfFuN5+OI/5y5JdQ=
X-Google-Smtp-Source: APXvYqz9SR9O0jgdDAlgbo1DH5ZmZpm0ICvWYwm3oRlMhsuWOshPN2VhUB7EWTmvaVVN7PUZKw5njA==
X-Received: by 2002:a62:1885:: with SMTP id 127mr50701361pfy.48.1558665429895;
        Thu, 23 May 2019 19:37:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id g8sm805937pfk.83.2019.05.23.19.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 19:37:09 -0700 (PDT)
Date:   Thu, 23 May 2019 19:37:07 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
Message-ID: <20190524023705.GD1936@localhost.localdomain>
References: <20190516044313.GA17751@localhost.localdomain>
 <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
 <cd06dc28-1076-259a-ba94-bad116771da8@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd06dc28-1076-259a-ba94-bad116771da8@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 16, 2019 at 09:55:33AM -0700, Guenter Roeck wrote:
> On 5/16/19 8:07 AM, Linus Torvalds wrote:
> >On Wed, May 15, 2019 at 9:43 PM Eduardo Valentin <edubezval@gmail.com> wrote:
> >>
> >>- thermal core has a new devm_* API for registering cooling devices, thanks to Guenter R.
> >>   I took the entire series, that is why you see changes on drivers/hwmon in this pull.
> >
> >This clashed badly with commit 6b1ec4789fb1 ("hwmon: (pwm-fan) Add RPM
> >support via external interrupt"), which added a timer to the pwm-fan
> >handling.
> >
> >In particular, that timer now needed the same kind of cleanup changes,
> >and I'd like you guys (particularly Guenther, who was involved on both
> >sides) to double-check my merge.
> >
> >The way I solved it was to just make the pwm_fan_pwm_disable()
> >callback do both the pwm_diable() _and_ the del_timer_sync() on the
> >new timer. That seemed to be the simplest solution that meshed with
> >the new devm cleanup model, but while I build-tested the result, I
> >obviously did no actual use testing. And maybe there's some reason why
> >that approach is flawed.
> >
> >Guenther?
> 
> Sorry for the trouble. Looks like I did too much cleanup this time around.
> 
> Looks ok. I'll have to send a follow-up patch - we should check the
> return value of devm_add_action_or_reset(). No idea why I didn't do that
> in this series. I'll do that after the commit window closes (and after
> I am back from vacation).

OK... From what I could tell, looked fine from a thermal perspective.

> 
> Thanks a lot for sorting this out.
> 
> Guenter
