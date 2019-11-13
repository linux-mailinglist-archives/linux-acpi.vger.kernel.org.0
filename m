Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585A1FABC7
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 09:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfKMIIR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 03:08:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36806 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfKMIIR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Nov 2019 03:08:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id d7so744100pls.3;
        Wed, 13 Nov 2019 00:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r/fMeIkVi21iCxbzdp/QtDTjojD14k6gpd4DZsn8Mfc=;
        b=Kia/RTbdDuikn8K2sIqQ13gm0tv6sDP07tY29CBKsGwKy97BoJsg7Fisv59LRmWi9S
         yBfqQxyHlQVknQDMTzD6ZEhXqWzVJV5j7u0jrvYH41wTM10AvlxQc7iF479JoRpX9oy8
         0GZmrsb1tFYDlx0adGQfM4UkXqjIwnim+zWbpcvmP/ZL0SGxHRY+B31QAemUXBOOwLdu
         dJtKJzR0vxeZGDzirMjmYGj4KArYJnHurFwX4KCzTj9H1jJPVBTkcmGyQkiAfrFyfAk3
         9d2nB/cSrsOjLt+32yllLHfrXLs9BaDHiJFMMxmhkxnJVPapOhq1OQh7xeh73a6GKdtS
         cDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r/fMeIkVi21iCxbzdp/QtDTjojD14k6gpd4DZsn8Mfc=;
        b=lYWvIL2MP/2oaBHRnxsFUFDV6fu3JW0MaGgK2gCl7klZhVPQcYnqGtZqWJdthey5XH
         FiNqb6IkdVHwjyeAll//+P0ZJYRW3Mp6dZCGnuJEBNrdh2BTKd/cYfpqgiARei7vcw3h
         Vtio2+uaQk/5H6cLmpTKvXNgMIsoSdsjzviTtYfmkhDn3pRaJUDzELsBZPgT75yHYKoW
         vDdRxtg/S4koeWqF6FgjeoMy3j5QkE/ozvAhMDGPQUnN6kDCqnr+CDoCejFu9LCtmqqf
         FDRfT3kS45lJwzOcc6lk9MGW9RHZSIZVFgTbhpFmzbrevBUcZuOGbCwbR2APx/ZGDngU
         sQDQ==
X-Gm-Message-State: APjAAAVU9QBgIm4DlTM2KiAdU22ex71Q1WooDCTRZq1RlMVWvBZpDQrR
        VzdUQkzEKod7UBU+dQzxGRo=
X-Google-Smtp-Source: APXvYqzlqfNgUOQUFtgA1SgTzDdplApu1eiVfos7BMyyaBnYSfBaHTGR9AWA/+byAysIo48izLxjYA==
X-Received: by 2002:a17:902:4c:: with SMTP id 70mr2315305pla.4.1573632496113;
        Wed, 13 Nov 2019 00:08:16 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id em16sm1417281pjb.21.2019.11.13.00.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 00:08:15 -0800 (PST)
Date:   Wed, 13 Nov 2019 00:08:13 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v8 1/6] software node: rename is_array to is_inline
Message-ID: <20191113080813.GO13374@dtor-ws>
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
 <20191108042225.45391-2-dmitry.torokhov@gmail.com>
 <87woc4s1xg.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87woc4s1xg.fsf@miraculix.mork.no>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 13, 2019 at 07:52:43AM +0100, Bjørn Mork wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> 
> > We do not need a special flag to know if we are dealing with an array,
> > as we can get that data from ratio between element length and the data
> > size, however we do need a flag to know whether the data is stored
> > directly inside property_entry or separately.
> 
> Doesn't a non-null prop->pointer tell you this?

No it does not because pointer is a part of a union.

> 
> And inverting the flag is unnecessarily risky IMHO. An all-zero prop
> might now result in dereferencing a NULL prop->pointer instead of using
> the empty prop->value.  Now I haven't looked at the code to see if this
> is a real problem.  But I believe it's better not having to do that
> anyway...

All-zero property is a terminator and thus we will not dereference
anything.

Thanks.

-- 
Dmitry
