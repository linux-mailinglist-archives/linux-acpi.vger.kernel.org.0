Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89A610E2E1
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Dec 2019 19:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfLASQN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 1 Dec 2019 13:16:13 -0500
Received: from mtax.cdmx.gob.mx ([187.141.35.197]:15297 "EHLO mtax.cdmx.gob.mx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfLASQN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 1 Dec 2019 13:16:13 -0500
X-Greylist: delayed 6393 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 13:16:12 EST
X-NAI-Header: Modified by McAfee Email Gateway (4500)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cdmx.gob.mx; s=72359050-3965-11E6-920A-0192F7A2F08E;
        t=1575217572; h=DKIM-Filter:X-Virus-Scanned:
         Content-Type:MIME-Version:Content-Transfer-Encoding:
         Content-Description:Subject:To:From:Date:Message-Id:
         X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-AnalysisOut:X-AnalysisOut:X-SAAS-TrackingID:
         X-NAI-Spam-Flag:X-NAI-Spam-Threshold:X-NAI-Spam-Score:
         X-NAI-Spam-Rules:X-NAI-Spam-Version; bh=M
        8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs4
        8=; b=xhuCx26vXuKVnsMeDQdJgBwj2b6xLeUr7Z0ImTzmdAYH
        8tADR3xOmCNTnkvtwQXzOaFx6x8Y23zt/zhBrXUgwGLroS9AID
        oGqn/2G3SjO7aZP3VZ4nHA/TGXsspxdwOi6G90pmeqXYrxjp1V
        uUHLJ7LdLfyr9JA9JnGqNh6en2M=
Received: from cdmx.gob.mx (correo.cdmx.gob.mx [10.250.108.150]) by mtax.cdmx.gob.mx with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 217f_5eaa_4e97b836_3001_4deb_b732_d97a6201fd3c;
        Sun, 01 Dec 2019 10:26:11 -0600
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 626921E26A7;
        Sun,  1 Dec 2019 10:18:04 -0600 (CST)
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FQf39G5UyYGT; Sun,  1 Dec 2019 10:18:04 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 6119B1E2587;
        Sun,  1 Dec 2019 10:12:55 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx 6119B1E2587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=72359050-3965-11E6-920A-0192F7A2F08E; t=1575216775;
        bh=M8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs48=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Message-Id;
        b=bMrjOgg0xS8AIOr8BUBVE6Rk5aKaIBCeemRStgGHobLEVP4VMe5rQuT2kBwJiw3Uz
         fYju/4ySm7vesYTJAo//7dFLjD/NkNdkZCrOZaxrEbk+N8VI65ryC620jyUF6eOQEs
         MGKxmX/mB7GVdjpS2ds+02W3nT6FsmgIE4ezF1X4=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gNmJ5-K0F5uU; Sun,  1 Dec 2019 10:12:55 -0600 (CST)
Received: from [192.168.0.104] (unknown [188.125.168.160])
        by cdmx.gob.mx (Postfix) with ESMTPSA id A86261E2D05;
        Sun,  1 Dec 2019 10:04:07 -0600 (CST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Congratulations
To:     Recipients <aac-styfe@cdmx.gob.mx>
From:   "Bishop Johnr" <aac-styfe@cdmx.gob.mx>
Date:   Sun, 01 Dec 2019 17:04:00 +0100
Message-Id: <20191201160407.A86261E2D05@cdmx.gob.mx>
X-AnalysisOut: [v=2.2 cv=aPKAkf1m c=1 sm=1 tr=0 p=6K-Ig8iNAUou4E5wYCEA:9 p]
X-AnalysisOut: [=zRI05YRXt28A:10 a=T6zFoIZ12MK39YzkfxrL7A==:117 a=9152RP8M]
X-AnalysisOut: [6GQqDhC/mI/QXQ==:17 a=8nJEP1OIZ-IA:10 a=pxVhFHJ0LMsA:10 a=]
X-AnalysisOut: [pGLkceISAAAA:8 a=wPNLvfGTeEIA:10 a=M8O0W8wq6qAA:10 a=Ygvjr]
X-AnalysisOut: [iKHvHXA2FhpO6d-:22]
X-SAAS-TrackingID: 2a9e3ed5.0.105115865.00-2344.176705396.s12p02m016.mxlogic.net
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 3
X-NAI-Spam-Score: -5000
X-NAI-Spam-Rules: 1 Rules triggered
        WHITELISTED=-5000
X-NAI-Spam-Version: 2.3.0.9418 : core <6686> : inlines <7165> : streams
 <1840193> : uri <2949749>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Money was donated to you by Mr and Mrs Allen and Violet Large, just contact=
 them with this email for more information =


EMail: allenandvioletlargeaward@gmail.com
