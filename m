Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F00C289002
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Oct 2020 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbgJIRcg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Oct 2020 13:32:36 -0400
Received: from sonic308-2.consmr.mail.bf2.yahoo.com ([74.6.130.41]:44170 "EHLO
        sonic308-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbgJIRcT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2020 13:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602264738; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=SOtT2VgeHfft266ugwCihXEtz4N4We2yXqjNq1w6PiXM/dyIr3L4ddrP9R8/EfLh3kaJhUuRPaECz3JgSatzWsbBb1XgkFc1Zhq+tuVTQPuokANhpf3PvRYaiu0KZQch1Keds+vmhITY07gTRsrZLEEu7lIoh5FeWwiou9oDOKFpv+XaqAFByH7lQArutGYOdiuUyzQcU5VrKxSyVyhXQfG0O4eiBwn9Cac3hOf7STEu2l1TVAEM7MisZCePRx3nFPQC9QaB+h7P8yv+QHQ1bnRIS5GrAGfBkWjWi8TodueylRd5ShFpN9cKmX5jnvf5yWXl428XTymMbwyZ6mRlwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602264738; bh=oweOsO+InI43hbFRLRBgRoVInuaToCahnYHWVDihvYz=; h=Date:From:Subject; b=Ud/Pn8nER++HsWwYThWr42M8s8VLv+MjEdDip6fb0SEuzvsr7zuHEouzGCKZ+TdznrXPBE14flfJdOp60LSsqGOPX6OUsQBneIY7ceRaC2uRiHoKfxasVHlZL0oKfi35RzujKfHn+2L5OT1q+sGU8wgCyMg6EdcqdbnDIEmZYMbq04Vo6/grFca1mYUtq5gJgJy5sitquRZAiIujsiXSNJ90alImV7rFovhmpOf/kNmrlkbowUi7HSpjTMjuTpCoDdllFZXokJk6kKzZsI0k95wkfmeXcisTNyyiUWKiEYvTTWCNS4rZrf2kGwfFadE0g1XwjrOCo/xzduuwRVmlWQ==
X-YMail-OSG: 5v9hkRwVM1lz8abwSsgESaGyahNwILSbkFwtLM7oGCnHCY7DgceUY5bBQW8ZtjA
 Gd3HTL2t2qAAIsGFPZbAZyn0JH3FZsMMMlJgDaCDDHn9ptWs_ZPO_cU9IEva6NxUEnSioUk9P_hi
 MDcnF04k010QJRqUH0K9RKZnMc7stui8J1WO2xEmO4p01M0wkb6QQxLYwhQemGIkUCeH.BD4BQWS
 oi0qiuufWT59XtCIlm._yy65l9x2iVuQyyyj7sKMSF1rffUNW5fyD.KXiihGQtMTaT4sEdckst6K
 djU.zsAv.eC4nUhX2xF9K2VCt_uBc70fTB2EaHhChVYeSiebFN_FzCnlqLrKYRzkCLiuKYNsZ7.S
 QBxH8JYfvkqT2NjNjhtbIQJs8GnFjblimaU1HQsn0Y8qOxRkx1arxjHlhLeNUOqbdr7MCVAywJtc
 hINIDXhr6SJnL8RypnjjG5xrDlRX6Ke.DeW5vRjm59VhqGGclwbfga9yTRT6YD2LnW0qemTco4ZY
 a7jn.2qkFGP1w5Ai5JornvwAwSkbxjF4Bg9d3E3ilMdmjwL0mOHhrm32_Bptbt5jJBf7NWq.GRYd
 xmSGbyRpP2oEfBdgRhdpvGXvOFHWetss9pKpcrPrQj7gYnB7LRn671uivYqVz.EUTu4kAPxxJckn
 wNvKt7smcWwvgC90mQAJZMzLe6bhY4qk7TpH.e3rcz1dExTEVLVCyi7bw0U8Zk6IpxoWy3pndzXz
 k42KkBMOGvVrqENIzTDE7yJEFRnJN.35by2WOZsA05IT0B6dNhJap7cpDlY56XuhkH45WJNkYwfC
 1k9BwCBhCbTMt6tKq4AFCvCOOskSomPgcR8JTmYFy_wq2U413Ak_Qg_e_h4DMUXkamjdef5SnB5J
 q.BRk2ZZCUbZ7OF8b1JsA0zthlW3RFYyYtir.LW6uhHHJnFvEP.vQ37O0NJQ2tSfoUap6D0MUvjg
 gDFQ1LWd1HkGcmmm4dYTwIAOxyMed14ukPRJ1LQKrWfPNqBOBfVJChgn0_zbOzCMm4T7KuV8dm4j
 0eA6RR8AaPb3Z7YOgLLW7aKw6ZrnKywh1wdf5PzcAWDY8ghpMvjZnKWJWOJtRHdMM3SPdJ.Nra_H
 Y6koh23aFm32J_vdxYVcGoTv8z9vJfzG37vluaxJ5Pj6HfylpHEsjGLwCR6CL2LFay6kwtME836F
 Bf78c6S1Wt6DZI0dQkHdlWZepHj769tL5ggmaFaSA_7xhssiBliZl.t3j.a980nxeEDpNDF7D73e
 NnhQwOx9F2KYTFRF9yy8QuZFhWF3Xh_8hjqwcCuoKB3hkKZh3yr8UEzDx..FL8wWr0DrRI5PycxE
 bGe_oH1USQlZTR7jvTmcilQZBSLG.vDlRSCo2Omii3u3u0djpbL7INSpKr1xAQnilZmn1ixqqs.2
 u6H9wEuoRJhVbncUCkXbm4ip1owWBmNwQKmV8yQ_DcM_DcVYT
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 9 Oct 2020 17:32:18 +0000
Date:   Fri, 9 Oct 2020 17:32:16 +0000 (UTC)
From:   Ms lisa Hugh <lisahugh531@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <648437096.795318.1602264736931@mail.yahoo.com>
Subject: BUSINESS CO-OPERATION FROM (Ms Lisa Hugh).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <648437096.795318.1602264736931.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
