Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA18111DB0C
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 01:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfLMASd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 19:18:33 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36450 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbfLMASd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Dec 2019 19:18:33 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so365106pjc.3;
        Thu, 12 Dec 2019 16:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PzzHuF1/xyDXmjRA/Sy26YXOVkhXhR/En4Zv+WEAAW4=;
        b=RdQdoTuZYwk0WhZ6dKeDhpzIoz+3UBW3mhQp1AcMk3gAO7kV4b8lYcsdEJ9Vjvz8tb
         HurOJf2iy2fyZeWlpN+t3v4Oa6bc8ZM81Mbvsbu4zGMI3UigEigLwNdVg0xQxIMhESLA
         0pvyQnzdqZvsjIQ3s36XpfHL8eEFHy8Qhsvp2sp0gYEDBc1W8ou3Sq7Uz+OR+CbToOzu
         v+6AMYgWx9eIkswJrrs4U7SjQ6PBppe9fkFQQYdmGhEme2hCNAZL349z63xVpLbxW0wv
         F2EXVyb6i9FbuwhjLlcGM4FoK7ZaU+sDZgL58iLFPvSuSVqy4s3mJ1jg2Tr0ImwM3TdC
         9kTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PzzHuF1/xyDXmjRA/Sy26YXOVkhXhR/En4Zv+WEAAW4=;
        b=JrnDKn8dqY1O5SDnZbVNBompZ1bM99ZQmxwAw500YDvlKjiFlzU622/2j5CduINg5U
         sOhGU5jBkqBswfKYf9UMzjU3Y2lhJ1kDum3EfHk7Wc9BU3nuWi2rTeTY0u1cGkUL9OAR
         MtcO2MA4MewwExjQwDHH8ybUy8+moY+5faqs0Z3bljjeGTAaX5dErPmdH4XhVsmbJeCI
         SPhBeXObzx+9h6HGx6Si7hB4is1BXkCz47mZrSaOGC1CE/L//DVXoykQzc9xQp5lXnnT
         IPeDCvGJtX1AeRSVATqhcHpZy6A2qE2HhSOWQevTR3f/j9pfrVDOg5AGI46NA4W99HOM
         eP7w==
X-Gm-Message-State: APjAAAXe20LV1+YPWf52xxYKQcC0jTHZmm1tCV8zJYFf6XKOYGrDr+R1
        ARQClpcFe78O+dAlrJgIDqE=
X-Google-Smtp-Source: APXvYqxB0b8bTu6GM9SrHUbEh+4wvHXMuSdDsPCgcW6GrHpWTNYrrcXqHSjNlrCTZvRvMFvNdjXTBQ==
X-Received: by 2002:a17:902:59da:: with SMTP id d26mr12731205plj.287.1576196312308;
        Thu, 12 Dec 2019 16:18:32 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g26sm7992685pfo.128.2019.12.12.16.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:18:31 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:18:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v9] software node: add basic tests for property entries
Message-ID: <20191213001829.GG101194@dtor-ws>
References: <201912040922.hUcG8uqP%lkp@intel.com>
 <20191204185315.GM50317@dtor-ws>
 <CAJZ5v0jDmNUqPVWH9XnwEreg=HucbtjWf6LW630iPMtBb9f1Nw@mail.gmail.com>
 <12135118.EjhP6glzqA@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12135118.EjhP6glzqA@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 11, 2019 at 11:53:05AM +0100, Rafael J. Wysocki wrote:
> On Monday, December 9, 2019 9:44:47 AM CET Rafael J. Wysocki wrote:
> > On Wed, Dec 4, 2019 at 7:53 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > This adds tests for creating software nodes with properties supplied by
> > > PROPERTY_ENTRY_XXX() macros and fetching and validating data from said
> > > nodes/properties.
> > >
> > > We are using KUnit framework for the tests.
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Applied (as 5.5 material), thanks!
> 
> And dropped again, because 0-day still complains.
> 
> I'm going to push the rest of the series to Linus this week.  The last patch
> can wait, even though it would be good to have it.

Could you point me to the 0-say compaint for the latest version as I did
not get it. I am still interested in sorting it all out.

Thanks.

-- 
Dmitry
