Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657692D0213
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 10:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgLFJAH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 04:00:07 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:55077 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbgLFJAG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2020 04:00:06 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 43317580236;
        Sun,  6 Dec 2020 03:59:00 -0500 (EST)
Received: from imap22 ([10.202.2.72])
  by compute2.internal (MEProxy); Sun, 06 Dec 2020 03:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mxxn.io; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=1YDfDVzlMf2IlCv8EmJK4ezcVHFDNQI
        i/OgN+ecGc0E=; b=KSGhOM/+hgQmmx9aKdEQfVsqRXaxHLK5uEJUKffOxkIfO91
        scf6kBSUoBB8qKCI4A/QAGZWVtaCjuBiXV+ShHRL5CXvcgmZu05r9ZTh8RUg8GSE
        JUoyPCizQLgwCg49Cahypv8bPbV4NT7J2VP891nc7T/2CjU+5B5xyZiVeqHaMJZo
        iycBgMmcEaqjh7fx8l1QSObaJW1q77e57lIeD5/dC6P0WbZ5HhPz7CgIKEwGHSdr
        6Ge1JYyFFw/NB9ACzCTqrPQUowyPbAl1Vvw4wPi15fyGQDQgN7xxd6YTE7kt2u8R
        X/MXid1rp41hBAOJx6Ub0wpeI9CE+lBqpZDLMXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=1YDfDV
        zlMf2IlCv8EmJK4ezcVHFDNQIi/OgN+ecGc0E=; b=OrxHyuD3fojaQi+d6Z3OuW
        zeB30+tAsnkZEEorkrAKkZbzRBRm17BPgPfOvvVbdB3sHHD3pnpWs+5SAwN6Nju3
        KUf6JP5gMy2MhU5Jqq3GwCl2zqibep4hsZXetKQR1ZolNJWN1pjZg5btpcfHBbz2
        Mncd3lBqbGeyXhf57o2j6RIuB7TRzOaxfIgIlDvohczXJ3YT2OY1MsR7cokZsY9v
        r2zoYE1hRBgrXac8RXeSYzGUxJh8PoCJ6xgNN0ccLh6N2vCvhW2xd/VrQDS+92WO
        xjeThhmgIwRa5CvZwL44gw5WtshC3ugigD3qIrLdYNkUD6vY+wW8aYDC0IIpLqqA
        ==
X-ME-Sender: <xms:U53MX0OZvwLAlRVHW1APUza3olElXJL0pN85gAbduBWHKzur4slxjQ>
    <xme:U53MX6-PAPuEceomsSNAMJ6Y2iPQasLtG86vqTgxNZQ2XyogCUtwwSpQJbnt0JDRY
    9LZuEHGfn5EFcDigw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpeeulhgr
    kkgpjfhrrghsthhnihhkuceosghlrgiisehmgiignhdrihhoqeenucggtffrrghtthgvrh
    hnpeejudekfffgjeeivdekveekgeetiefgvedvveekieefffelueffueffueejueevfeen
    ucffohhmrghinheplhhkmhhlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghlrgiisehmgiignhdrihho
X-ME-Proxy: <xmx:U53MX7S_CI9GWqlOiGWRrl-JyPDqRF3BTQQw9iIR595nbp9l0mFuAw>
    <xmx:U53MX8vDyNlzM6X3IqK2dg8mwHO0yTWgERyweP6fyj8_filU78d1ug>
    <xmx:U53MX8eDy98MiZUYnJVTJiOITjkK3ZEIZ8E4iggi3OJzSVdYDqUWhQ>
    <xmx:VJ3MXwFUfIl3ycYCMgISGnzcDOrp4o5UNcG-P1HPTTPpTp3Dsu4iAA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D1A6E62A005E; Sun,  6 Dec 2020 03:58:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <1b4fe1fd-592d-4a88-b156-fbf6af2df428@www.fastmail.com>
In-Reply-To: <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
 <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
Date:   Sun, 06 Dec 2020 17:58:32 +0900
From:   =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>
To:     "Hans de Goede" <hdegoede@redhat.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "Maximilian Luz" <luzmaximilian@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Mark Gross" <mgross@linux.intel.com>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>, "Rob Herring" <robh@kernel.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Len Brown" <lenb@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Michal Marek" <michal.lkml@markovi.net>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Dorian Stoll" <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_0/9]_Add_support_for_Microsoft_Surface_System_Ag?=
 =?UTF-8?Q?gregator_Module?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> 
> > More on that, the whole purpose of proposed interface is to debug and
> > not intended to be used by any user space code.
> 
> The purpose is to provide raw access to the Surface Serial Hub protocol,
> just like we provide raw access to USB devices and have hidraw devices.
> 
> So this goes a litle beyond just debugging; and eventually the choice
> may be made to implement some functionality with userspace drivers,
> just like we do for some HID and USB devices.
> 
> Still I agree with you that adding new userspace API is something which
> needs to be considered carefully. So I will look at this closely when
> reviewing this set.

To add to that: this was previously a debugfs interface but was moved to misc after review on the initial RFC:
https://lkml.org/lkml/2020/9/24/96
