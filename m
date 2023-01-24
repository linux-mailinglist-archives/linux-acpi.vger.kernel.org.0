Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD0967A387
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 21:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjAXUBi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 15:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjAXUBf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 15:01:35 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436D6EAE
        for <linux-acpi@vger.kernel.org>; Tue, 24 Jan 2023 12:01:34 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x36so19464421ede.13
        for <linux-acpi@vger.kernel.org>; Tue, 24 Jan 2023 12:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Epk4RocLWHvvndFvO9gs/F9/Rl6mQimBZFrkTzK3aL4=;
        b=LdUKEuPDGl0aePrHdDhscv9WUsSjGvuh4uunuO24xIdAsl9OplLrqmfB6BqtMdsohp
         ISYo0uHy9jfG9XTqWCFHQmR3Z5GUDzIsbumjkuwmiyGetdKHKBWi62hdGE/cXyolxEJJ
         syLC8oyla2nyZRpaMYAUspLvagLAkRQSZeGUUYGEjfl8s5b/iLdn0Zd9zN7OUmv+Nhss
         DoGemi3U1W4bnEzFYNX1fleIOfNHZX7rvwMtCnlLBfR4azkwiCd06GdOtL1LkVFr9oag
         ynaGRwwzqH7dfXWBIdFWQg5RBAZGyUMUtmhKMJ7A7kwmkqdrMjQ0Fv/xkjNpX2s9am1i
         DWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Epk4RocLWHvvndFvO9gs/F9/Rl6mQimBZFrkTzK3aL4=;
        b=1VXsALH5ys4Fz5EWlFhTSUDNT1J7ySiM5QbxkmWWjpRf2YuGY1szpeL9tl1dcFz6zv
         GRc/Km7BA5ln/MOtH5SC/ajQdmULuDAmyqDrVm5Qa1gj3/izj9wbxsT6cdR1fRBNKtAR
         brlppEMp4apUl3boYpIYIBaOduCo8dFJICUblgtFhTFxRaae89dqQHLYDmjzSZXwhtyU
         3lhA8GEbs+DCUjtgwpCy+hQ3vQQdz1s4uIHFD+vTUd3Y3F0T0poYdAg7gdccOtb/6jdP
         yDvdzH0IZSPi1ktLA0L5FcoJTa/vqgpoupZKbQ7Bd1GPu1JfWMUlENJOMoSw8z7OsHRn
         tycA==
X-Gm-Message-State: AFqh2kqGk97b5hOU9QGlzwRNvHzGKnoTzXE4J6coCR84U3h7nMWlI5x1
        jI9Ke+qgZXF1ItADq84C37/jad+bdl62TV7hPhU=
X-Google-Smtp-Source: AMrXdXv8d6BbbMq+I/Q+FTQaDqq9djGCQvwWfuncNzJgHTZViNAUevt94LZpjPtPEZN24eNlnP00fo9wDjE8lALWqGU=
X-Received: by 2002:a05:6402:358e:b0:49e:ea1e:ac9c with SMTP id
 y14-20020a056402358e00b0049eea1eac9cmr2426784edc.70.1674590492143; Tue, 24
 Jan 2023 12:01:32 -0800 (PST)
MIME-Version: 1.0
Reply-To: unitednationameric@gmail.com
Sender: dr.vineetkumarliza1987@gmail.com
Received: by 2002:a54:23c2:0:b0:1f8:466a:8b5e with HTTP; Tue, 24 Jan 2023
 12:01:31 -0800 (PST)
From:   UNITED NATIONS HEADQUARTER OFFICE AMERICA 
        <unitednationameric@gmail.com>
Date:   Tue, 24 Jan 2023 12:01:31 -0800
X-Google-Sender-Auth: VaMrtNjcfg0xR0jEkfDRtIL_T3k
Message-ID: <CA+bY3ZsyXV1w4gWKmia5g5-_uZSSPfhQp3e2XFFsa-RyfpuZCA@mail.gmail.com>
Subject: UNITED NATIONS HEADQUARTER OFFICE FROM NEW-YORK AMERICA,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:532 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5228]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dr.vineetkumarliza1987[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dr.vineetkumarliza1987[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.6 URG_BIZ Contains urgent matter
        *  1.0 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Official Name:United States of America
Capitol:Washington
Population:318,814,000
Languages:English, Spanish, numerous others
Geographic Region:Americas Northern America
Geographic Size (km sq):9,526,468
Year of UN Membership:1945
Year of Present State Formation:1787
Current UN Representative: Linda Thomas-Greenfield
Email: united.nation.america@usa.com
Wedsite:-https://www.un.org

                                             24/01/2023
ATTENTION:

This message is converting to you from united nation Headquarter from
New-York America to know what is exactly the reason of being
ungrateful to the received compensation fund, meanwhile you have to
explain to us how the fund was divided to each and every needful one
in your country because united nation compersated you with (=E2=82=AC
2,500,000.00 Million EUR ) to use part of the money and help orphan
and widowers including the people covid19 affected in your country for
our proper  documentary.

It had been officially known that out of the (150) lucky winners that
has received their compensation fund out there worldwide sum of (=E2=82=AC
2,500,000.00 Million EUR ) per each of the lucky winner as it was
listed in our list files and individuals, that was offered by United
Nations compensation in last year 2022,(149) has all returned back
with appreciation letter to united nation office remainder
you.Woodforest National Bank reported to united nation that they has
paid all the lucky winners,after we checked our file we saw that
(149)has come and thanked united nation and explained how they used
there money remaining you to complete the total number(150).we need
your urgent response for our proper documentry.

You are adviced to explain in details how the fund was divided to the
needful as the purpose on your reply mail.

Linda Thomas-Greenfield
PRESIDENT OF THE UNITED NATIONS GENERAL ASSEMBLY
In New York, the normal working hours are from 9:30 am to 5:30 pm,
Monday through Friday, with a break of one hour for lunch. During the
period when the General Assembly is in session (1 October to 31
December), the working hours are from 9:30 am to 6:00 pm
