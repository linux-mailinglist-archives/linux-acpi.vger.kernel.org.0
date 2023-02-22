Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8AE69FDD3
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Feb 2023 22:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjBVVl4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Feb 2023 16:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjBVVlz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Feb 2023 16:41:55 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D67231E2C;
        Wed, 22 Feb 2023 13:41:53 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230222214151usoutp011a7909c04a265d354640d5cce4f4babf~GQ3wjpTnM1696916969usoutp01b;
        Wed, 22 Feb 2023 21:41:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230222214151usoutp011a7909c04a265d354640d5cce4f4babf~GQ3wjpTnM1696916969usoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677102111;
        bh=LPOYnY1Abu2MYRNN0Up70ibVPDy5s5C6eVW/VlCfsSA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=IQtx/RO+Dzp6xVa72OVw3DYV9UyxHL+a/URbEjUeBS08l9fpLcqoJ6GjbUP8ejYgH
         jhES8Ftm/UvnCYAUEdGZ+9oxOFY+tbw72CEymQ6Q8N8a+OZzDxNzRqhrRxjSziDDTe
         OalRFJycwqlTVbrU0o9xftp31LjWJ4t5RY6aR0G8=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230222214151uscas1p1f939224fd14ace1b04548b5593a2bf56~GQ3wUtHE42613626136uscas1p1C;
        Wed, 22 Feb 2023 21:41:51 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id C5.62.12196.F1C86F36; Wed,
        22 Feb 2023 16:41:51 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230222214151uscas1p26d53b2e198f63a1f382fe575c6c25070~GQ3wAyhDD0572405724uscas1p2e;
        Wed, 22 Feb 2023 21:41:51 +0000 (GMT)
X-AuditID: cbfec370-83dfe70000012fa4-21-63f68c1fa75e
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 22.E0.17110.E1C86F36; Wed,
        22 Feb 2023 16:41:50 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 22 Feb 2023 13:41:50 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        22 Feb 2023 13:41:50 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH v2 00/20] CXL RAM and the 'Soft Reserved' => 'System
 RAM' default
Thread-Topic: [PATCH v2 00/20] CXL RAM and the 'Soft Reserved' => 'System
        RAM' default
Thread-Index: AQHZPS7TjaXMIoSW1Eqtx3n221KG+a7Nu/OAgAACg4CADloxgA==
Date:   Wed, 22 Feb 2023 21:41:49 +0000
Message-ID: <20230222214140.GA1276133@bgt-140510-bm03>
In-Reply-To: <Y+qB9T/PCZ6TpYlK@memverge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B5676B7EC3BAA41B8A1E05B7711F9CD@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djX87ryPd+SDV7PF7eYPvUCo8WLDe2M
        FiduNrJZrL65htHi6/pfzBYNTY9YLPY/fc5isWrhNTaLM925Fsv39TNanJ91isXi3pr/rBb3
        +xwsbk04xuTA5zG74SKLR8uRt6wei/e8ZPLY9GkSu8e8k4EeGz/+Z/d4v+8qm8fU2fUe67dc
        ZfH4vEkugCuKyyYlNSezLLVI3y6BK+POsZesBX/VKra8387awLhVuouRk0NCwERiemsnaxcj
        F4eQwEpGiR+vX7NBOK1MEj2bHzDCVG0/dIEFIrGWUeL2jm/sEM4nRonju3rYQKqEBJYxSix4
        nwNiswkoSuzr2g4U5+AQEdCT+PjfE6SeWeAJi8Thtmdg9cIC4RJ/u/qZQWwRgQiJadNusEDU
        O0n8fOEMYrIIqEq8OqEAUsErYCaxs286C4jNKaAj8avvAJjNKCAm8f3UGiYQm1lAXOLWk/lM
        EDcLSiyavYcZwhaT+LfrIRuErShx//tLdoh6HYkFuz+xQdh2Eo3vP7BA2NoSyxa+ZobYKyhx
        cuYTFoheSYmDK26Aw0FCYDWnxJwzp6CGukhsXnOPHcKWlvh7dxkTyP0SAskSqz5yQYRzJOYv
        2QI1x1pi4Z/1TBMYVWYhOXsWkpNmITlpFpKTZiE5aQEj6ypG8dLi4tz01GLjvNRyveLE3OLS
        vHS95PzcTYzAVHj63+GCHYy3bn3UO8TIxMF4iFGCg1lJhPc/7+dkId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4ryGtieThQTSE0tSs1NTC1KLYLJMHJxSDUw1Blc/yDvaJPYstzO/ccFLPGTeE2m/
        c38NLU9mHSo5N7Ge70ZvY75h8wENhbqHET3mausUDu+eu/iG5aaaYweD088Vpt8osWR/sXnd
        lTh2Tk3dmCcfO85aye64z10hvLa1y8D4ieUrlgiV/T35AjU8/U6lOQfXbe6Ju/K9Ue+wVk6A
        SyHzf+N9677xuaZ6PL0yVWzD57/sz2Ukc/pC3x243/VA7gBXQoAm58/V9b8qpdY3Bzf4fTtb
        KKQ4tVztqWnmNHFN9e5zqq7sRfuanN9dX7HJ4AHXm1gvvR+2ppaRS8zPu167/3/qfJMLqqfM
        9xtuOKHdft+ooean05mV83c53+C0L/09j3XHm1+X25RYijMSDbWYi4oTAfYL1Tj0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LJbGCaqCvX8y3Z4P1rG4vpUy8wWrzY0M5o
        ceJmI5vF6ptrGC2+rv/FbNHQ9IjFYv/T5ywWqxZeY7M4051rsXxfP6PF+VmnWCzurfnPanG/
        z8Hi1oRjTA58HrMbLrJ4tBx5y+qxeM9LJo9Nnyaxe8w7Geix8eN/do/3+66yeUydXe+xfstV
        Fo/Pm+QCuKK4bFJSczLLUov07RK4Mu4ce8la8FetYsv77awNjFuluxg5OSQETCS2H7rA0sXI
        xSEksJpRov9NEzuE84lR4va5e2wQzjJGic/7W5lBWtgEFCX2dW0HSnBwiAjoSXz87wlSwyzw
        hEXicNszNpAaYYFwifdLjoPViwhESDy92MkOUe8k8fOFM4jJIqAq8eqEAkgFr4CZxM6+6VBH
        zGSU6Ph2iwkkwSmgI/Gr7wALiM0oICbx/dQasDizgLjErSfzmSA+EJBYsuc8M4QtKvHy8T9W
        CFtR4v73l+wQ9ToSC3Z/YoOw7SQa339ggbC1JZYtfM0McYSgxMmZT1ggeiUlDq64wTKBUWIW
        knWzkIyahWTULCSjZiEZtYCRdRWjeGlxcW56RbFRXmq5XnFibnFpXrpecn7uJkZgKjn973D0
        Dsbbtz7qHWJk4mA8xCjBwawkwvuf93OyEG9KYmVValF+fFFpTmrxIUZpDhYlcd6XURPjhQTS
        E0tSs1NTC1KLYLJMHJxSDUyqDvxT1gSydISmRH6Q+aH+p/d7X+eCBp6y92s/zj/javPys6fh
        2cmGJ+Wsjt8/Y62u+6r+wpy7ZQmPvl+6e2TheoOHTB6Fn63ipp4vM2Dc47XkrNz5SsaJnQyb
        QgPm57BqnLbibjzBxaW7+FFe6rq2bRLqe1K/fplcZdTCsVHEaP209R1sTtvT7XkfiF+f1rd8
        Rnu5Qx9PVmW3bXq63fW6X9v/b+TIry7K63r+9lGgIf+BhlUbj+Szyd7hMWH83Hvp7HyTqV9M
        ah7Gd5hp8E+a6VPAq82wssQrf6LctGuZijMuWdxTEZnVMNO2n9NzT8iUT+vT5ObmN812f6pV
        l7OwWFn/4E/zRkuxVXsjM5VYijMSDbWYi4oTAWayOpaUAwAA
X-CMS-MailID: 20230222214151uscas1p26d53b2e198f63a1f382fe575c6c25070
CMS-TYPE: 301P
X-CMS-RootMailID: 20230222214151uscas1p26d53b2e198f63a1f382fe575c6c25070
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <Y+p/2S4rnrOOyZ8w@memverge.com> <Y+qB9T/PCZ6TpYlK@memverge.com>
        <CGME20230222214151uscas1p26d53b2e198f63a1f382fe575c6c25070@uscas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 13, 2023 at 01:31:17PM -0500, Gregory Price wrote:

> On Mon, Feb 13, 2023 at 01:22:17PM -0500, Gregory Price wrote:
> > On Fri, Feb 10, 2023 at 01:05:21AM -0800, Dan Williams wrote:
> > > Changes since v1: [1]
> > > [... snip ...]
> > [... snip ...]
> > Really i see these decoders and device mappings setup:
> > port1 -> mem2
> > port2 -> mem1
> > port3 -> mem0
>=20
> small correction:
> port1 -> mem1
> port3 -> mem0
> port2 -> mem2
>=20
> >=20
> > Therefore I should expect
> > decoder0.0 -> mem2
> > decoder0.1 -> mem1
> > decoder0.2 -> mem0
> >=20
>=20
> this end up mapping this way, which is still further jumbled.
>=20
> Something feels like there's an off-by-one
>=20

Currently, the naming of memdevs can be out-of-order due to the
following two reasons,
1. At kernel side, cxl port driver does async device probe, which can
change the memdev naming even within a single OS boot and among multiple
time of device enumeration. The pattern can be observed with following
steps in the guest,
	loop(){
	a) modprobe cxl_xxx
	b)cxl list  --> you will see the memdev name changes (like mem0->mem1).
	c) rmmod cxl_xxx
	}
This behaviour can be avoided by using sync device probe by making the
following change
--------------------------------------------
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 258004f34281..f3f90fad62b5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -663,7 +663,7 @@ static struct pci_driver cxl_pci_driver =3D {
 	.probe			=3D cxl_pci_probe,
 	.err_handler		=3D &cxl_error_handlers,
 	.driver	=3D {
-		.probe_type	=3D PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type =3D PROBE_FORCE_SYNCHRONOUS,
 	},
 };
-------------------------------------------

The above patch, you will see consistent memdev naming within one
OS boot, however, the order can be still different from what we expect with
the qemu config options we use. We need to make some change at QEMU side
also as shown below.

2. Currently in Qemu, multiple components at the same topology level are
stored in a data structure called QLIST as defined in
include/qemu/queue.h. When enqueuing a component, current qemu code uses
QLIST_INSERT_HEAD to insert the item at the head, but when iterating, it
uses QLIST_FOREACH/QLIST_FOREACH_SAFE which is also from the head of the
list. That is to say, if we enqueue items P1,P2,P3 in order, when iterating=
,
we get P3,P2,P1. I have a simple test with the below code change(always
insert to the list tail), the order issue is fixed.

---------------------------------------------------------------------------=
-
diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index e029e7bf66..15491960e1 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -130,7 +130,7 @@ struct {                                               =
                 \
         (listelm)->field.le_prev =3D &(elm)->field.le_next;               =
\
 } while (/*CONSTCOND*/0)
=20
-#define QLIST_INSERT_HEAD(head, elm, field) do {                        \
+#define QLIST_INSERT_HEAD_OLD(head, elm, field) do {                    \
         if (((elm)->field.le_next =3D (head)->lh_first) !=3D NULL)        =
  \
                 (head)->lh_first->field.le_prev =3D &(elm)->field.le_next;=
\
         (head)->lh_first =3D (elm);                                       =
\
@@ -146,6 +146,20 @@ struct {                                              =
                  \
         (elm)->field.le_prev =3D NULL;                                    =
\
 } while (/*CONSTCOND*/0)
=20
+#define QLIST_INSERT_TAIL(head, elm, field) do {                        \
+        typeof(elm) last_p =3D (head)->lh_first;                          =
\
+        while (last_p && last_p->field.le_next)                         \
+            last_p =3D last_p->field.le_next;                             =
\
+        if (last_p)                                                     \
+            QLIST_INSERT_AFTER(last_p, elm, field);                     \
+        else                                                            \
+            QLIST_INSERT_HEAD_OLD(head, elm, field);                    \
+} while (/*CONSTCOND*/0)
+
+#define QLIST_INSERT_HEAD(head, elm, field) do {                        \
+        QLIST_INSERT_TAIL(head, elm, field);                            \
+} while (/*CONSTCOND*/0)
+
 /*
  * Like QLIST_REMOVE() but safe to call when elm is not in a list
  */
---------------------------------------------------------------------------=
--

The memdev naming order can also cause confusion when creating regions
for multiple memdevs under different HBs as in the kernel code, we enforce
HB check to ensure the target position matches the CFMW configuration.
To avoid the confusion, we can use "cxl list -TD" to find out the target
position for a memdev, but it is kind of annoying to do it before
creating region.
