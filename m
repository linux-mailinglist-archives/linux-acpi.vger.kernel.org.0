Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F03D138BB7
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2020 07:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAMGQp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jan 2020 01:16:45 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:37277 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgAMGQp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jan 2020 01:16:45 -0500
IronPort-SDR: ePVpGIrltg4LNRT4XXwlJPYtosn8jqm/MpBlNprqkzQtwhxk47flxTdE9vZkoIWFRA/q7lVE2w
 Cjkj9qK2KZ1A==
IronPort-PHdr: =?us-ascii?q?9a23=3AKaxxcRQ3xRZ3dge9a9Xbbv7RJtpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6ybRSN2/xhgRfzUJnB7Loc0qyK6vumAzJRqsfd+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUbgI9vJqk1xx?=
 =?us-ascii?q?bGv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/GfQhsJtkK1Uuhehphxmz4PKZ4GVLuJ+fqTHfdwAWW?=
 =?us-ascii?q?pOQN9dWDJHAo+lc4YPE/YBMvxEoIn9uVQOqAWxBQ+wBO/21DBIgGb606o90+?=
 =?us-ascii?q?QnDw7H3BUsEMwIsH/JqNn4OrseXfywwKTO0D7Nbe5Z2S3l5YbGch4hu++CU7?=
 =?us-ascii?q?Ftf8Xe1UYhGBjIjkmSpIP5Iz+ZyvgBv3ad4uF9VeyvkWknqwRprza12Mgslp?=
 =?us-ascii?q?fGhpgIwV/E8iV5xok1LsC/RU5jf9GkDIVftzuUNotxRMMiTHpluCYhyrIdpZ?=
 =?us-ascii?q?G3ZjQFyJMixxLFa/yHcJGF7xT+X+iSOTd1nGxpdK+9ihqo7EStxPHwWtOq3F?=
 =?us-ascii?q?tFtCZInNnBu3YQ3BLJ8MeHUOFy/kK51DaK0ADc9/9LLFgvlareN54h2rkwlo?=
 =?us-ascii?q?cPsUjbHi/5hkH2jKiOe0Uh4Oeo6uDnYq/4qZ+YK4N5hRvyMropmsOiG+s4PA?=
 =?us-ascii?q?8OX26F9uimyrLj5lX1QLRMjvIojqnUqI7WKdkZq6KjHgNY3Jov5wyhAzqpyt?=
 =?us-ascii?q?gVk3kKIEpAeB2djojpP1/OIOr/Dfe6m1msiClkx+zYMb37DJTNKX7DkLj6cL?=
 =?us-ascii?q?Z98E5T0xY8wcpD6JJTD7ENOvLzWkzpuNzCEhA5KxC0w/rgCNhl0oMeWGSPAr?=
 =?us-ascii?q?KWMa/Lq1CH+vovI+iXaY8LtzbyNeIl6+TtjXAng18de7em3Z8NZHC/BPRmLB?=
 =?us-ascii?q?bRXX25htYHDHdPtwEmTcT0h1CYFz1efXC/W+Q7/D5oMo++CZb/QdWVjaCMxm?=
 =?us-ascii?q?+EGZtZLjReB0yBC2jvcYqEWPcXYim6LcpokzhCXr+kHdwPzxar4Tf317d9Zt?=
 =?us-ascii?q?XT/CJQ4YruyNVv+OrVmjky7jZ/Sc+a1ieNTDcnzSszWzYq0fUm8gRGwVCZ3P?=
 =?us-ascii?q?0j26RV?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ETKgAEChxemCMYgtkUBjMYGgEBAQE?=
 =?us-ascii?q?BAQEBAQMBAQEBEQEBAQICAQEBAYF7AgEBFwEBgS6BTVIgEpNPgU0fg0OLY4E?=
 =?us-ascii?q?Agx4VhggTDIFbDQEBAQEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAE?=
 =?us-ascii?q?BAhABAQEBAQYNCwYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4M?=
 =?us-ascii?q?EgksBATOFJJc7AY0EDQ0ChR2CJQQKgQmBGiOBNgGMGBqBQT+BIyGCKwgBggG?=
 =?us-ascii?q?CfwESAWyCSIJZBI1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxCCRQ+BCYg?=
 =?us-ascii?q?DhE6BfaM3V4EMDXpxMxqCJhqBIE8YDYgbji1AgRYQAk+JLoIyAQE?=
X-IPAS-Result: =?us-ascii?q?A2ETKgAEChxemCMYgtkUBjMYGgEBAQEBAQEBAQMBAQEBE?=
 =?us-ascii?q?QEBAQICAQEBAYF7AgEBFwEBgS6BTVIgEpNPgU0fg0OLY4EAgx4VhggTDIFbD?=
 =?us-ascii?q?QEBAQEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAEBAhABAQEBAQYNC?=
 =?us-ascii?q?wYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4MEgksBATOFJJc7A?=
 =?us-ascii?q?Y0EDQ0ChR2CJQQKgQmBGiOBNgGMGBqBQT+BIyGCKwgBggGCfwESAWyCSIJZB?=
 =?us-ascii?q?I1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxCCRQ+BCYgDhE6BfaM3V4EMD?=
 =?us-ascii?q?XpxMxqCJhqBIE8YDYgbji1AgRYQAk+JLoIyAQE?=
X-IronPort-AV: E=Sophos;i="5.69,427,1571695200"; 
   d="scan'208";a="304601038"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 13 Jan 2020 07:16:42 +0100
Received: (qmail 24629 invoked from network); 12 Jan 2020 05:00:22 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-acpi@vger.kernel.org>; 12 Jan 2020 05:00:22 -0000
Date:   Sun, 12 Jan 2020 06:00:18 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-acpi@vger.kernel.org
Message-ID: <23038799.460862.1578805222391.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

