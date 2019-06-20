Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35A24CDAD
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfFTMZ4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 08:25:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37475 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfFTMZ4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jun 2019 08:25:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so2970698wme.2
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2019 05:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nGbwT1fOo/WcjbkFQ3vvfod2lQownHb8jwDrl6e2Yzk=;
        b=CoPiD8NXuY79eSws3YaYvFv5PqRMRItqh+Yea5nAQAhZwlCElCUngtM6Yt5DY0rkf1
         oYiIsFQ5dFh1bKoP9oWtH3jQeEq9nzihwUW7FxVj9/D84o1ZYLTEeNk44akVaNP4ZPof
         XIdOkl+JLPTNaMVtUCV+PYg0sDn8YE2Ok4ag/ZI4UVLZ4+IFcc1FbH+2BZP147R9UUqB
         36p40GNpJbb0T9UOPjamUUuvHoCeM0jsuwUz2C7Rh4/P2GzyvUD+Yt+3QG9Nm5Tx7vqx
         T4YWi58KKkGszAsVYNp8XLrfW/9JUVLK+gHQnf8UB32GOJqblFrDZXuu2uN6p6xwY6GY
         SEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nGbwT1fOo/WcjbkFQ3vvfod2lQownHb8jwDrl6e2Yzk=;
        b=irDk5bUCB3ueXZIFZmXi/8oGuiMlXx226X1Y6DHI1uA/sksZrYjWBB/CY+491t/wm4
         TQvoxa/HmAokUBzSxH93Wi+5CpV+SEG1lqfakAgcwJ2AikYjDGSy3VFcvyNtm41wGeE9
         +2utbm44eGcS9zQjEXNwwG1vHPvuz4JnBA2SWrCG4MY0Qfr07W7RiVEPW0h1QUoHhXxU
         we5wU9I42Ae5K1thlal2VFqMnHOeg/ZZJfb+Bx2SmefNBBYUeqnJ/iKY9VqHHXIK0N5t
         IopBrQJ6J2C5EgnPDlGJp33pHeiaI0T9vLR6ZxHNuwF+lhNqcLA1tEge9q8O7OVruCVp
         15eA==
X-Gm-Message-State: APjAAAXdTtloqsJMLKYPly6jiv/kixKjTNCZ9bJOsoAnwRvKbK5wR1cP
        32VtkKWfxMWd/f7LFUZiVSkN4A==
X-Google-Smtp-Source: APXvYqz6jnLBVywer3zqPeTDaiXVrGtBx8wKm76F0MgDMf6oUh3M5VIM8YxAxe12Bk0fOIKqMpgUlA==
X-Received: by 2002:a1c:a842:: with SMTP id r63mr2705755wme.117.1561033553765;
        Thu, 20 Jun 2019 05:25:53 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id p26sm21241456wrp.58.2019.06.20.05.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 05:25:53 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:25:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        leif.lindholm@linaro.org
Subject: Re: [RFC PATCH] acpi/arm64: ignore 5.1 FADTs that are reported as 5.0
Message-ID: <20190620122551.GC4699@dell>
References: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
 <20190619122434.GA25656@e107155-lin>
 <20190620075732.GB4699@dell>
 <20190620094937.GB20872@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190620094937.GB20872@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 20 Jun 2019, Lorenzo Pieralisi wrote:

> On Thu, Jun 20, 2019 at 08:57:32AM +0100, Lee Jones wrote:
> > On Wed, 19 Jun 2019, Sudeep Holla wrote:
> > 
> > > On Wed, Jun 19, 2019 at 02:18:31PM +0200, Ard Biesheuvel wrote:
> > > > Some Qualcomm Snapdragon based laptops built to run Microsoft Windows
> > > > are clearly ACPI 5.1 based, given that that is the first ACPI revision
> > > > that supports ARM, and introduced the FADT 'arm_boot_flags' field,
> > > > which has a non-zero field on those systems.
> > > > 
> > > > So in these cases, infer from the ARM boot flags that the FADT must be
> > > > 5.1 or later, and treat it as 5.1.
> > > > 
> > > 
> > > Makes sense and looks simple to me.
> > > 
> > > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > Could we pleeeeease have this in for v5.3?
> > 
> > We have available, consumer-level platforms that rely on this change.
> 
> But we do not have the kernel infrastructure to support them so
> I am fine with it but urgency is questionable as far as I am
> concerned.

Yes we do.  At least, we will in v5.3.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
